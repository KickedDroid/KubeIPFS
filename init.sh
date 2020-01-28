#! /bin/bash

set -e

echo "  _  ___    _ ____  ______   _____ _____  ______ _____ 
 | |/ | |  | |  _ \|  ____| |_   _|  __ \|  ____/ ____|
 | ' /| |  | | |_) | |__      | | | |__) | |__ | (___  
 |  < | |  | |  _ <|  __|     | | |  ___/|  __| \___ \ 
 | . \| |__| | |_) | |____   _| |_| |    | |    ____) |
 |_|\__\____/|____/|______| |_____|_|    |_|   |_____/ 
                                                       
                                                       

"


kubectl apply -f ipfs-cluster-config.yaml
echo "Applying config.."

kubectl apply -f ipfs-cluster-deployment.yaml

echo "Deploying IPFS Cluster"

printf "Waiting for nodes to start....\n"
sleep 5
while true; do
    sleep 10
    statuses=`kubectl get pods -l 'app=ipfs-cluster' -o jsonpath='{.items[*].status.phase}' | xargs -n1`
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

kubectl get pods 

echo " "

sleep 5 

echo "PEERS"

POD=$(kubectl get pod -l app=ipfs-cluster -o jsonpath="{.items[0].metadata.name}")

kubectl exec $POD ipfs-cluster-ctl peers ls

echo  "done"


set +ex
