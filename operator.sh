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
linkerd install | kubectl apply -f -
linkerd check

kubectl kudo init


kubectl kudo install ./temporal-operator

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

linkerd inject ./temporal-operator/templates | kubectl apply -f -

kubectl kudo get instances


set +ex
