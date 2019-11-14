# Kubernetes IPFS Cluster

## Create a Kubernetes Cluster

`minikube start`

`eval $(minikube docker-env).`

`minikube dashboard`

`kubectl run example-node —image=docker.io/ipfs/go-ipf`

`kube expose deployment example-node —type=NodePort —port=8080` 

# Kube IPFS Cluster

## Create Deployment

``kubectl apply -f https://github.com/AIDXNZ/KubeIPFS/blob/master/ipfs-cluster-deployment.yaml``


