#! /bin/bash

set -e

echo "  _  ___    _ ____  ______   _____ _____  ______ _____ 
 | |/ | |  | |  _ \|  ____| |_   _|  __ \|  ____/ ____|
 | ' /| |  | | |_) | |__      | | | |__) | |__ | (___  
 |  < | |  | |  _ <|  __|     | | |  ___/|  __| \___ \ 
 | . \| |__| | |_) | |____   _| |_| |    | |    ____) |
 |_|\__\____/|____/|______| |_____|_|    |_|   |_____/ 
                                                       
                                                       

"

echo "Deploying IPFS Cluster"
kubectl apply -f ipfs-cluster-deployment.yaml

printf "Waiting for nodes to start....\n"
sleep 30


echo "PEERS"

POD=$(kubectl get pod -l app=ipfs-cluster -o jsonpath="{.items[0].metadata.name}")

kubectl exec $POD ipfs-cluster-ctl peers ls

echo  "done"


set +ex
