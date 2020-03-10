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

linkerd install | kubectl apply -f -
echo "Applying service mesh.."
linkerd check

echo "Generating erlang cookie..."
kubectl create secret generic rabbitmq-config --from-literal=erlang-cookie=c-is-for-cookie-thats-good-enough-for-me

sleep 1

echo "Deploying postgres...."
cat postgres.yaml | linkerd inject - | kubectl apply -f -

kubectl apply -f temporal-config.yaml

kubectl get services 

sleep 10 
echo "Deploying Temporal...."
cat test-env.yaml | linkerd inject - | kubectl apply -f -


echo "Waiting for all containers to be running..."

while true; do
    sleep 10
    statuses=`kubectl get pods -l 'app=temporal' -o jsonpath='{.items[*].status.phase}' | xargs -n1`
    echo $statuses
    all_running="yes"
    for s in $statuses; do
        if [[ "$s" != "Running" ]]; then
            all_running="no"
        fi
    done
    if [[ $all_running == "yes" ]]; then
        break
    fi
done

kubectl get services 
kubectl get pods 


set +ex
