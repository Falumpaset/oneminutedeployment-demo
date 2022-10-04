# The One Minute Deployment
The goal of this repo to work as a proof of concept for the proposed [One Minute Deployment](https://blog.devgenius.io/the-one-minute-deployment-rethinking-kubernetes-deployments-3f6785918855).

However, this is a revised iteration of the initial idea which I discuss [here]().
//TODO
## Try it yourself
In this tutorial, you will deploy a simple NodeJS application to your cluster. The application outputs Hello World to your brower through Kubernetes port-forwarding.
Afterwards, you will alter the deployment to showcase the simplicity and speed of our approach.
Finally, we will clean your cluster.

### Prerequisites
In case you are familiar with the VS Code Dev Container extention, the predefined [devcontainer configuration](./.devcontainer) is most convenient.\
⚠⚠ Please makes sure that your kubeconfig is accessible in the container. Do so by moving it into ~/.kube/config or export it ```export KUBECONFIG=/path/file/in/container```.

Otherwise you need
- Access to a running Kubernetes Cluster
- Access to a container registry, populate the [Markdown](./Makefile) with the credentials
- NodeJS and yarn installed 
- [Oras](https://oras.land/cli/) installed on your machine. 
- Kubectl installed

### Steps
- make yourself familiar with the [source code](./src/index.js) and the [deployment scripts](./deployment/scripts/).
- in the project root type ```make initial_deploy``` to initially deploy the application. kubectl will create a `oneminutedeployment` namespace and install the deployment into it.
- open [127.0.0.1:1337](http://127.0.0.1:1337) to verify that the application works
- open [index.js](./src/index.js) and alter line 6 to ```res.send('This Rocks!')```
- in the project root type ```make deploy```
- open [127.0.0.1:1337](http://127.0.0.1:1337) to verify that the changes made it to the cluster
- finally ```make teardown``` to clear it up
