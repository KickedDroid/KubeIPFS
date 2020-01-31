# Kube IPFS

## Create a Kubernetes Cluster

`minikube start`

`eval $(minikube docker-env).`

`minikube dashboard`


## Deploy IPFS-Cluster

In your terminal run the init script

``sh init.sh``


### The terminal should output this: 

The pods in the cluster
````
NAME                            READY   STATUS    RESTARTS   AGE
ipfs-cluster-6b58ccf766-2vp6g   2/2     Running   0          15s
ipfs-cluster-6b58ccf766-5w7bh   2/2     Running   0          15s
ipfs-cluster-6b58ccf766-xd878   2/2     Running   0          15s
````

IPFS-Cluster Peers and addresses
````
12D3KooWCaV62hVPmb9VbVX7cymAv2HDo8VNHQHCJVv9s6cyKZoS | cluster | Sees 2 other peers
  > Addresses:
    - /ip4/127.0.0.1/tcp/9096/p2p/12D3KooWCaV62hVPmb9VbVX7cymAv2HDo8VNHQHCJVv9s6cyKZoS
    - /ip4/172.17.0.9/tcp/9096/p2p/12D3KooWCaV62hVPmb9VbVX7cymAv2HDo8VNHQHCJVv9s6cyKZoS
  > IPFS: QmaRAtcktLVzm75xgkkuLnxLpiWacTqnEUqWbFbMWxKJbV
    - /ip4/127.0.0.1/tcp/4001/p2p/QmaRAtcktLVzm75xgkkuLnxLpiWacTqnEUqWbFbMWxKJbV
    - /ip4/172.17.0.9/tcp/4001/p2p/QmaRAtcktLVzm75xgkkuLnxLpiWacTqnEUqWbFbMWxKJbV
12D3KooWDMAXVHHauvZv9hvfw7z4c6Q6DvkfnQJeSBbM9ttxhwm1 | cluster | Sees 2 other peers
  > Addresses:
    - /ip4/127.0.0.1/tcp/9096/p2p/12D3KooWDMAXVHHauvZv9hvfw7z4c6Q6DvkfnQJeSBbM9ttxhwm1
    - /ip4/172.17.0.7/tcp/9096/p2p/12D3KooWDMAXVHHauvZv9hvfw7z4c6Q6DvkfnQJeSBbM9ttxhwm1
  > IPFS: QmSvjSXDASbCKih2dZHoamKd6hUAxLGHVTzpJtZYeq1bH1
    - /ip4/127.0.0.1/tcp/4001/p2p/QmSvjSXDASbCKih2dZHoamKd6hUAxLGHVTzpJtZYeq1bH1
    - /ip4/172.17.0.7/tcp/4001/p2p/QmSvjSXDASbCKih2dZHoamKd6hUAxLGHVTzpJtZYeq1bH1
12D3KooWQpZh2jyRrr4DU44QPpUjwugcpYAk3D7jsiKCaiQM4syu | cluster | Sees 2 other peers
  > Addresses:
    - /ip4/127.0.0.1/tcp/9096/p2p/12D3KooWQpZh2jyRrr4DU44QPpUjwugcpYAk3D7jsiKCaiQM4syu
    - /ip4/172.17.0.8/tcp/9096/p2p/12D3KooWQpZh2jyRrr4DU44QPpUjwugcpYAk3D7jsiKCaiQM4syu
  > IPFS: QmcjkgYcPYTVxx6HdBHigsXgSRso61nAJWJeimddG8HbZD
    - /ip4/127.0.0.1/tcp/4001/p2p/QmcjkgYcPYTVxx6HdBHigsXgSRso61nAJWJeimddG8HbZD
    - /ip4/172.17.0.8/tcp/4001/p2p/QmcjkgYcPYTVxx6HdBHigsXgSRso61nAJWJeimddG8HbZD
````

## Some useful commands

Get pod name to be executed  

``POD=$(kubectl get pod -l app=ipfs-cluster -o jsonpath="{.items[0].metadata.name}")``

Get Cluster Peers

``kubectl exec $POD ipfs-cluster-ctl peers ls``

List pined objects

``kubectl exec $POD ipfs-cluster-ctl pin ls``
