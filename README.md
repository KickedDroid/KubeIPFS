# Kubernetes IPFS Cluster

Use Cases

- Distributed Pining.
- Auto-scaling and self healing Network
- Large ipfs clusters

Selector service selects nodes to pin on. If an object being pinned has more than 8,000 links it's chunked and distributed throughout the cluster

## Overview

a cluster node can control only one IPFS node. Now that one IPFS node can truly be just one IPFS node, or it can be IPFS proxy provided by some other cluster, or multiple IPFS nodes pretending to be a single node say with a reverse proxy.
Cluster talks to IPFS using it's http apis. So, as long as the thing connected to cluster mimicks IPFS apis, it should work (I haven't really tried this though).

### Sharding IPFS Cluster

The master cluster will Ingest pins and allocate them to sub clusters. The sub cluster will take a IPFS object and distribute the object links to the follower nodes. Lets say a cluter recived a pin request of a 100gb file. The master cluster will shard the object links containing 10 gb each to 10 cluster peers. Each cluster peer shards its given 10GB into 1gb chunks and pins the chunks within its own sub cluster. 

What this accomplishes is distributed pinning along with Sharding the ipfs dag. When a ipfs cat request is called ipfs resolves the merkle dag and finds the required objects reguardless of where its located in the cluster. This also allows for a highly scalable ipfs cluster using composite clusters. 

[]()

## Kube IPFS

Kube IPFS is a deployment of go-ipfs to a kubernetes cluster and accessed via a reverse proxy. 

## Create a Kubernetes Cluster

`minikube start`

`eval $(minikube docker-env).`

`minikube dashboard`

`kubectl run example-node —image=docker.io/ipfs/go-ipf`

`kube expose deployment example-node —type=NodePort —port=8080` 

# Kube IPFS Cluster

## Create Deployment

``kubectl apply -f https://github.com/AIDXNZ/KubeIPFS/blob/master/ipfs-cluster-deployment.yaml``


