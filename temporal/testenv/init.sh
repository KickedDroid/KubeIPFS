#! /bin/bash

set -e

echo "
  _______                                   _ 
 |__   __|                                 | |
    | | ___ _ __ ___  _ __   ___  _ __ __ _| |
    | |/ _ \ '_ ' _ \| '_ \ / _ \| '__/ _' | |
    | |  __/ | | | | | |_) | (_) | | | (_| | |
    |_|\___|_| |_| |_| .__/ \___/|_|  \__,_|_|
                     | |                      
                     |_|                      


"

echo "Inititalizing prerequisites....."

echo "Generating erlang cookie..."
kubectl create secret generic rabbitmq-config --from-literal=erlang-cookie=c-is-for-cookie-thats-good-enough-for-me

sleep 1

echo "Deploying postgres...."
kubectl apply -f postgres.yaml

kubectl apply -f temporal-config.yaml

kubectl get services


set +ex
