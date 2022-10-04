REGISTRY=""
REGISTRY_USERNAME=""
REGISTRY_PASSWORD=""

export REGISTRY
export REGISTRY_USERNAME
export REGISTRY_PASSWORD

check_shell_env:
	@echo "Checking if all varibales are set"
	./deployment/scripts/prerun.sh $(REGISTRY) $(REGISTRY_USERNAME) $(REGISTRY_PASSWORD)
	@echo "ENV is set correctly! Ready for deployment 🚀"

push:	build
	@echo "Pushing Code to $(REGISTRY)"
	./deployment/scripts/push.sh $(REGISTRY) $(REGISTRY_USERNAME) $(REGISTRY_PASSWORD) $(KUBECONFIG)
	@echo "Finished Pushing"
	
build:
	./deployment/scripts/build.sh

initial_deploy:	check_shell_env push
	@echo "Inital Deployment running"
	./deployment/scripts/deploy.sh true $(REGISTRY) $(REGISTRY_USERNAME) $(REGISTRY_PASSWORD)
	@echo "Waiting 10 sec for pod to get ready"
	sleep 10
	kubectl port-forward svc/helloworld-service -n oneminutedeployment 1337:80

deploy: push
	@echo "Patching deployment"
	./deployment/scripts/deploy.sh false $(REGISTRY)
	@echo "Waiting 50 sec for kubernetes service to switch over to new pod"
	sleep 50
	kubectl port-forward svc/helloworld-service -n oneminutedeployment 1337:80

port_forward:
	@echo "Forwarding 3000 to 1337"
	kubectl port-forward svc/helloworld-service -n oneminutedeployment 1337:80

teardown:
	kubectl delete -f ./deployment/deployment.yaml
	kubectl delete ns oneminutedeployment
