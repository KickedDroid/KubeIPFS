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
  
