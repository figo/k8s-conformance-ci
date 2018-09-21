#!/bin/sh
set -e

# launch conformance tests
export KUBECONFIG=${KUBECONFIG}

# deploy rbac file for ccm
kubectl create -f ccm/cloud-controller-manager-roles.yaml

# update vsphere.conf
sed -i 's/VSPHERE_SERVER/'"$VSPHERE_SERVER"'/g' ccm/vsphere.conf
sed -i 's/VSPHERE_USER/'"$VSPHERE_USER"'/g' ccm/vsphere.conf
sed -i 's/VSPHERE_PASSWORD/'"$VSPHERE_PASSWORD"'/g' ccm/vsphere.conf

# deploy vcenter credential in configmap
kubectl create configmap cloud-config --from-file=ccm/vsphere.conf --namespace=kube-system

# deploy ccm
kubectl create -f ccm/vsphere-cloud-controller-manager-pod.yaml

source ./util.sh
# wait all pods are running
wait_until_pods_running
