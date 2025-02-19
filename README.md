# kubernetes-helm
A flask app is deployed on Kubernetes using helm charts:
- **deployment helm chart:** 
- **secret management:** creates and applies [regcred secret](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/) to be used in deployment. A second hem chart can be created for secret management too! Or it can be manaaged by kubectl.

GHCR is used instead of DockerHub for container registry. A `GITHUB_TOKEN` is needed for CICD read/write access to GHCR.
CICD is done with GitHub Actions. A `KUBECONFIG` secret might be needed to configure kubectl so that the GitHub Actions runner has access to the cluster.

### Prerequisites

- Docker
- Kind (Kubernetes in Docker)
- Kubectl
- Helm
**************************
#### The deployment is automated via cicd.yml script, but manual steps for testing is as below: 

### Docker
Login to DockerHub:
```
echo "DockerHub_TOKEN" | docker login -u [docker_username] --password-stdin # DockerHub_PAT is personal access token with read/write access to the DockerHub
```
Build, run and test the docker image locally. Add .dockerignore to optimize docker build
```
docker build -t myapp:latest .
docker run -p 6666:6666 myapp
```
Push the image to the image repository:
```
docker tag myapp:latest [docker_username]/myapp:latest
docker push [docker_username]/myapp:latest
```
But since we use GHCR here, 'GITHUB_TOKEN' will be used for programatic access to GHCR. 
Create 'GITHUB_TOKEN' withread/write package permissions in GitHub developer settings.
```
docker tag myapp:latest [github_username]/myapp:latest
docker push ghcr.io/[github_username]/myapp:latest
```

### Kubernetes

Create and verify the Kubernetes cluster
```
kind create cluster --name myapp-cluster
kubectl cluster-info --context kind-myapp-cluster
```

create helm chart for the app, 
```
helm create myapp-chart
```
edit the helm chart deployment, sevice and value yaml files
to config the secrets, visit https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/

then deploy the helm chart to the cluster and verify
```
helm install myapp ./myapp-chart

kubectl get pods
kubectl get svc
```
use port forwarding to access the app
```
kubectl port-forward svc/myapp-myapp-chart 8080:6666
```

to clean up:
```
$ kind delete cluster --name myapp-cluster
```
