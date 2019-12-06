# Kube IPFS

## Create a Kubernetes Cluster

`minikube start`

`eval $(minikube docker-env).`

`minikube dashboard`


## Deploy IPFS-Cluster

In your terminal run the init script

``sh init.sh``

The output should look like this: 

````
NAME                            READY   STATUS    RESTARTS   AGE
ipfs-cluster-6b58ccf766-2vp6g   2/2     Running   0          15s
ipfs-cluster-6b58ccf766-5w7bh   2/2     Running   0          15s
ipfs-cluster-6b58ccf766-xd878   2/2     Running   0          15s
````
