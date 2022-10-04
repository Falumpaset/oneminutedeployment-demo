#! /bin/bash

set_replacement_values () {
    echo "replacing placeholder values in deployment.yaml see deployment_generated.yaml for the final output"
  	sed -e 's,IMAGE_TAG,'$1:$COMMIT_HASH', g' -e 's,REGISTRY_USER_PLACEHOLDER,'$2', g' -e 's,REGISTRY_PASSWORD_PLACEHOLDER,'$3', g' ./deployment/deployment.yaml > ./deployment/deployment_generated.yaml
} 

initial_deploy () {
    kubectl create ns oneminutedeployment
    kubectl apply -f ./deployment/deployment_generated.yaml
}

patch_deployment_kubectl () {
    echo "patching deployment to load image with hash" $COMMIT_HASH
    kubectl set env deployment/hello-world IMAGE=$1:$COMMIT_HASH -n oneminutedeployment
}

deploy () {
    echo "deploying" $2 
    COMMIT_HASH=$(./deployment/scripts/hash.sh)
    if [[ $1 = true ]] 
    then
    set_replacement_values $2 $3 $4
    initial_deploy 
    else
    patch_deployment_kubectl $2
    fi
}

deploy $1 $2 $3 $4
