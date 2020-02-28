# Temporal Kubernetes Stack


## Overview
This is an overview of the architecture implementing Temporal on Kubernetes. A Kubernetes cluster needs to implement a CNI and CSI. Better known as Container Network Interface and Container Storage Interface. 

#### Linkerd Service Mesh 

Linkerd is used for the service mesh. It utilizes the Rust programming language to run incredibley fast proxies. It also includes very detailed metrics to monitor our traffic to IPFS Nodes. As IPFS uses libp2p, Linkerd's latency aware load balancing works well with distributed networks. 

[Learn more about Linkerd](https://linkerd.io/)


#### Rook Storage Orchestration 

Rook turns distributed storage systems into self-managing, self-scaling, self-healing storage services. It is a framework that allows multiple storage providers and one day hopefully we can use IPFS as a provider to Rook.io to have all the capabilites of IPFS. 

Minio is the storage provider used because it provides interoperablility with s3x in the future so no need to re-implement new architechture. 

[Learn more about rook.io](https://rook.io/)
[Learn more about minio](https://min.io)



## Config 

In order to config your Temporal deployment you need to have a configmap. Otherwise it uses the default values. All of the config options are mapped to env vars. An example of a temporal config map: 

``````
apiVersion: v1
kind: ConfigMap
metadata:
  name: temporal-config
  namespace: default
data:

  CONFIG_DAG: ""

  # Api config
  API_CONNECTION_CERTIFICATES_CERTPATH: "/temporal/api.cert"
  API_CONNECTION_CERTIFICATES_KEYPATH: "/temporal/api.key"

  
  # database config
  DATABASE_NAME: "temporal"
  DATABASE_URL:  "0.0.0.0.0"
  DATABASE_PORT: "5432"
  DATABASE_USERNAME: "postgres"
  DATABASE_PASSWORD: "password123"


  # IPFS config
  IPFS_API_CONNECTION_HOST: "127.0.0.1"
  IPFS_API_CONNECTION_PORT: "5001"
  IPFS_KEYSTORE_PATH: "/tmp"

  # IPFS Cluster config
  IPFS_CLUSTER_API_CONNECTION_HOST: "127.0.0.1"
  IPFS_CLUSTER_API_CONNECTION_PORT: "9094"
    
  #rabbitmq config
  RABBITMQ_URL: "amqp://127.0.0.1:5672/" 
``````

### IPFS Cluster


Everything in the deafualt config.json can be specified in env vars like so:

``````
 apiVersion: v1
kind: ConfigMap
metadata:
  name: ipfs-cluster-config
  namespace: default
data:
  
  # Cluster config 
  CLUSTER_PEERNAME: "cluster"
  CLUSTER_SECRET: ""
  CLUSTER_LEAVEONSHUTDOWN: "false"
  CLUSTER_LISTENMULTIADDRESS: "/ip4/0.0.0.0/tcp/9096"

  # Replication factors  -1 == all
  # CLUSTER_REPLICATIONFACTORMIN: "1"
  CLUSTER_REPLICATIONFACTORMAX: "-1"

  # IPFS Proxy 
  API_IPFSPROXY_LISTENMULTIADDRESS: "/ip4/127.0.0.1/tcp/9095"
  API_IPFSPROXY_NODEMULTIADDRESS: "/ip4/127.0.0.1/tcp/5001"
  
  # Rest API 
  API_RESTAPI_HTTPLISTENMULTIADDRESS: "/ip4/127.0.0.1/tcp/9094"
  

  # IPFS Connector
  IPFSCONNECTOR_IPFSHTTP_NODEMULTIADDRESS: "/ip4/127.0.0.1/tcp/5001"

  # Observations 
  #OBSERVATIONS_METRICS_ENABLESTATS: true
  #OBSERVATIONS_METRICS_PROMETHEUSENDPOINT: "/ip4/0.0.0.0/tcp/8888"

  # IPFS config
  IPFS_API_CONNECTION_HOST: "127.0.0.1"
  IPFS_API_CONNECTION_PORT: "5001"
  IPFS_KEYSTORE_PATH: "/tmp"

  # IPFS Cluster config
  IPFS_CLUSTER_API_CONNECTION_HOST: "127.0.0.1"
  IPFS_CLUSTER_API_CONNECTION_PORT: "9094"
          
``````



### Postgres

To specify your postgres credentials you can change the values in the configmap

*postgres-configmap.yaml*
``````
apiVersion: v1
kind: ConfigMap
metadata:
  name: postgres-config
  labels:
    app: postgres
data:
  POSTGRES_DB: temporal
  POSTGRES_USER: postgres
  POSTGRES_PASSWORD: password123
  ``````
  
#### Rabbitmq

Generate an erlang cookie:

``kubectl create secret generic rabbitmq-config --from-literal=erlang-cookie=c-is-for-cookie-thats-good-enough-for-me``

