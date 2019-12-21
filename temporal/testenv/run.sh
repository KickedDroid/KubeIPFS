#! /bin/bash

set -e


echo "Deploying Temporal...."
kubectl apply -f test-env.yaml


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



set +ex