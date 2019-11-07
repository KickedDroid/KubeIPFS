#! /bin/bash

set -e

echo "Create go-ipfs deployment"
kubectl create -f https://github.com/AIDXNZ/KubeIPFS

sleep 2

echo
echo "Waiting for all containers to be running"

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

sleep 5

echo
echo "Adding peers to cluster"
pods=`kubectl get pods -l 'app=ipfs-cluster,role=peer' -o jsonpath='{.items[*].metadata.name}' | xargs -n1`
bootstrapper=`kubectl get pods -l 'app=ipfs-cluster,role=bootstrapper' -o jsonpath='{.items[*].metadata.name}'`

for p in $pods; do
    addr=$(echo "/ip4/"`kubectl get pods $p -o jsonpath='{.status.podIP}'`"/tcp/9096/ipfs/"`kubectl exec $p -- ipfs-cluster-ctl --enc json id | jq -r .id`)
    kubectl exec $bootstrapper -- ipfs-cluster-ctl peers add "$addr"
done

set +ex