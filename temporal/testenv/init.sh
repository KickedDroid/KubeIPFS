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
kubectl create secret generic rabbitmq-config --from-literal=erlang-cookie=c-is-for-cookie-thats-good-enough-for-me

sleep 1

echo "Deploying Temporal Stack...."
kubectl apply -f /temporal/testenv/test-env.yaml

sleep 20

POD=$(kubectl get pod -l app=temporal -o jsonpath="{.items[0].metadata.name}")

kubectl get all

set +ex
