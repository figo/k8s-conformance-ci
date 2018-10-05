#!/bin/sh
set -e

# launch conformance tests
export KUBECONFIG=${KUBECONFIG}

# deploy cni
kubectl create -f cni/kube-flannel.yml

source ./util.sh

# wait for all pods are running
wait_until_pods_running

# TODO: CNI may take a minute to create route rules for all nodes,
if [ "${CNI_WAIT}" = "" ]; then CNI_WAIT=90; fi
sleep "${CNI_WAIT}"
