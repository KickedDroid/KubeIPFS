# Testenv

This is a testenv for the Temporal Kubernetes Stack

## Usage

In the testenv folder run the init script. 

``sh init.sh``

The terminal should output this: 

``````
NAME         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
kubernetes   ClusterIP   10.96.0.1        <none>        443/TCP    61m
postgres     ClusterIP   10.103.116.186   <none>        5432/TCP   0s
``````

The postgres CLUSTER-IP is the `DATABASE_URL` we point to in the temporal-config.yaml file.

### Edit temporal-config.yaml

In the temporal-config.yaml change the `DATABASE_URL` to the CLUSTER-IP of the postgres service

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
  DATABASE_URL:  "10.103.116.186"
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

## Deploy Temporal 

Once everything is configured and saved, in your terminal run:

``sh run.sh``

TODO
