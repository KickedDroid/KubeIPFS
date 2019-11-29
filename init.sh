#! /bin/bash

set -e

echo "  _  ___    _ ____  ______   _____ _____  ______ _____ 
 | |/ | |  | |  _ \|  ____| |_   _|  __ \|  ____/ ____|
 | ' /| |  | | |_) | |__      | | | |__) | |__ | (___  
 |  < | |  | |  _ <|  __|     | | |  ___/|  __| \___ \ 
 | . \| |__| | |_) | |____   _| |_| |    | |    ____) |
 |_|\__\____/|____/|______| |_____|_|    |_|   |_____/ 
                                                       
                                                       

"

echo "Generating erlang cookie..."
#kubectl create secret generic rabbitmq-config --from-literal=erlang-cookie=c-is-for-cookie-thats-good-enough-for-me

sleep 1

echo "Deploying rabbitmq..."
#kubectl apply -f /temporal/rabbitmq/rabbitmq-deployment.yaml

sleep 1

echo "Applying postgres config..."
#kubectl create -f /temporal/postgres/postgres-configmap.yaml
echo "Deploying postgres"
#kubectl create -f /temporal/postgres/postgres-deployment.yaml

sleep 1

echo "Deploying IPFS Cluster"
kubectl apply -f ipfs-cluster-deployment.yaml

printf "Finding Peers....\n"
sleep 20


echo "PEERS"

POD=$(kubectl get pod -l app=ipfs-cluster -o jsonpath="{.items[0].metadata.name}")

kubectl exec $POD ipfs-cluster-ctl peers ls

echo  "done"


set +ex
