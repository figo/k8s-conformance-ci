#!/bin/sh
set -e

# launch conformance tests
export KUBECONFIG=${KUBECONFIG}

# deploy cni
kubectl create -f cni/kube-flannel.yml

source ./util.sh

# wait for all pods are running
wait_until_pods_running

# TODO: looks like CNI may take a minute to create route rules for all nodes
sleep 90
