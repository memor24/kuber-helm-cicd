# kubernetes-helm-cicd
A flask app is deployed on Kubernetes using helm charts:
```
helm create myapp-chart
```
- **testing helm charts:** modify the helm charts based on the app requirements and test them before actual deployment:
```
helm lint myapp-chart
helm template myapp-chart
helm install --dry-run --debug myapp-chart
```
- **deployment automation:** is done with helm and CICD pipeline using GitHub Actions which is triggered on push to the main branch.
- **secret management:** creates and applies [regcred secret](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/) to be used in deployment. GitHub container registry (GHCR) is used as image registry instead of DockerHub. A `GITHUB_TOKEN` is needed for CICD read/write access to GHCR. If using other image registries or CICD tools, a `KUBECONFIG` secret might be needed to configure kubectl so that a CICD runner/agent has access to the cluster.


### Prerequisites

- Docker
- Kind (Kubernetes in Docker)
- `kubectl`
- `helm`

