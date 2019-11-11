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

ipfs pin ls
QmQ5vhrL7uv6tuoN9KeVBwd4PwfQkXdVVmDLUZuTNxqgvm indirect
QmXgqKTbzdh83pQtKFb19SpMCpDDcKR2ujqk3pKph9aCNF indirect
QmY5heUM5qgRubMDD1og9fhCPA6QdkMp3QCwd4s7gJsyE7 indirect
QmYCvbfNbCwFR45HiNP45rwJgvatpiW38D961L5qAhUM5Y indirect
QmejvEPop4D7YUadeGqYWmZxHhLc4JBUCzJJHWMzdcMe2y indirect
QmPZ9gcCEpqKTo6aq61g2nXGUhM4iCL3ewB6LDXZCtioEB indirect
QmS4ustL54uo8FzR9455qaxZwuMiUhyvMcX9Ba8nUH4uVv recursive
QmUNLLsPACCz1vLxQVkXqqLX5R1X345qqfHbsf67hvA3Nn recursive
QmZTR5bcpQD7cFgTorqxZDYaew1Wqgfbd2ud9QqGPAkK2V indirect

ipfs pin ls
QmXgqKTbzdh83pQtKFb19SpMCpDDcKR2ujqk3pKph9aCNF indirect
QmZTR5bcpQD7cFgTorqxZDYaew1Wqgfbd2ud9QqGPAkK2V indirect
QmejvEPop4D7YUadeGqYWmZxHhLc4JBUCzJJHWMzdcMe2y indirect
QmPZ9gcCEpqKTo6aq61g2nXGUhM4iCL3ewB6LDXZCtioEB indirect
QmS4ustL54uo8FzR9455qaxZwuMiUhyvMcX9Ba8nUH4uVv recursive
QmUNLLsPACCz1vLxQVkXqqLX5R1X345qqfHbsf67hvA3Nn recursive
QmYCvbfNbCwFR45HiNP45rwJgvatpiW38D961L5qAhUM5Y indirect
QmP8jTG1m9GSDJLCbeWhVSVgEzCPPwXRdCRuJtQ5Tz9Kc9 recursive
QmQ5vhrL7uv6tuoN9KeVBwd4PwfQkXdVVmDLUZuTNxqgvm indirect
QmY5heUM5qgRubMDD1og9fhCPA6QdkMp3QCwd4s7gJsyE7 indirect

ipfs repo stat
NumObjects: 31
RepoSize: 196286
StorageMax: 10000000000
RepoPath: /data/ipfs
Version: fs-repo@7

ipfs repo stat
NumObjects: 28
RepoSize: 171643
StorageMax: 10000000000
RepoPath: /data/ipfs
Version: fs-repo@7

kubectl run ipfs-cluster --image=docker.io/ipfs/ipfs-cluster --port=9096 --port=9094 --port=9095
