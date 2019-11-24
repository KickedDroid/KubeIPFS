# Temporal Kubernetes Stack


## Usage 
Before you spin up a Temporal Node first you need to deploy a Postgres Database and a rabbitmq cluster. 

### Rabbitmq

Generate an erlang cookie:

``kubectl create secret generic rabbitmq-config --from-literal=erlang-cookie=c-is-for-cookie-thats-good-enough-for-me``

Add the yaml file

``kubectl apply -f /rabbitmq/rabbitmq-deployment.yaml``

### Postgres

In order to add postgres to a kubernetes deployment we need to setup the following yaml spec files.

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
    Apply the postrgres-configmap.yaml
  
  ``kubectl create -f postgres-configmap.yaml``
  
  ``kubectl create -f postgres-storage.yaml``
  
  ``kubectl create -f postgres-deployment.yaml``
  
### IPFS Cluster


Edit the ipfs-cluster-deployment.yaml cluster sercret env var

``````
    spec:
      containers:
      - name: ipfs-cluster
        image: "docker.io/ipfs/ipfs-cluster:latest"
        env: 
        - name: CLUSTER_SECRET
          value: "YOUR_CLUSTER_SECRET"
          
``````

``kubectl apply -f ipfs-cluster-deployment.yaml``

### Temporal 

In order to change the config.json to a user defined one we begin the deployment with an init container to fetch the config.json and have the following containers mount off of it. 

``````
    spec:

      initContainers: 
        - name: config
          image: busybox
          command: 
          - wget
          - "-O"
          - "/temporal/config.json"
          - https://raw.githubusercontent.com/AIDXNZ/KubeIPFS/master/config.json
          volumeMounts:
            - name: workdir
            mountPath: "/temporal"
    volumes: 
      - name: workdir
        emptyDir: {}
    
``````
