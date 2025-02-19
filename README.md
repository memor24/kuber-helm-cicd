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

