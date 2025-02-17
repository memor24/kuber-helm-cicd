# kubernetes-cicd

Here are the steps to deploy the app on Kubernetes, most of which is automated in the cicd script.
## Docker
	Build, run and test the docker image locally
	```
	docker build -t myapp:latest .
	docker run -p 6666:6666 myapp
	```
	Add .dockerignore to optimize docker build

	push the image to the image repository
	```
	docker login
	docker tag myapp:latest memo24/myapp:latest
	docker push memo24/myapp:latest
 ## Kubernetes
 create and verify the Kubernetes cluster
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
