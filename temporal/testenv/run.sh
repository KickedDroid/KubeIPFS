#! /bin/bash

set -e

echo "Deploying Temporal...."
kubectl apply -f test-env.yaml

sleep 10

kubectl get all 

set +ex