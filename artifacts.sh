#!/bin/sh

# Input:  artifacts repo ("upstream-latest" or "local")
# Output: artifacts location as enviroment variables
#         $CNI_ARTIFACT
#         $ETCD_ARTIFACT
#         $KUBE_APISERVER_ARTIFACT
#         $KUBE_CONTROLLER_MANAGER_ARTIFACT
#         $CLOUD_CONTROLLER_MANAGER_ARTIFACT
#         $KUBE_SCHEDULER_ARTIFACT
#         $KUBELET_ARTIFACT
#         $KUBE_PROXY_ARTIFACT
#         $KUBE_PROXY_TAG
#         $KUBECTL_ARTIFACT
#         $KUBETEST_ARTIFACT
#         $KUBERNETES_ARTIFACT

source ./util.sh
ARTIFACTS_REPO="upstream-latest"
if [ ! "$1" = "" ]; then ARTIFACTS_REPO=$1; fi
if [ ! "$2" = "" ]; then ENVS_FILE=$2; fi

BASE_URL=""
BUILD=""
if [ "$ARTIFACTS_REPO" = "upstream-ci-latest" ] ; then
  K8S_RELEASE_DEV_BASE_URL="https://storage.googleapis.com/kubernetes-release-dev"
  BUILD=$(curl "${K8S_RELEASE_DEV_BASE_URL}"/ci/latest.txt)
  BASE_URL="${K8S_RELEASE_DEV_BASE_URL}/ci/${BUILD}"

elif [ "$ARTIFACTS_REPO" = "upstream-release" ] ; then
  if [ "$3" = "" ]
  then
    echo "release version need be provided" 
    exit 1
  else
    VERSION=$3
  fi
  K8S_RELEASE_DEV_BASE_URL="https://storage.googleapis.com/kubernetes-release"
  BUILD=$(curl "${K8S_RELEASE_DEV_BASE_URL}"/release/latest-"${VERSION}".txt)
  BASE_URL="${K8S_RELEASE_DEV_BASE_URL}/release/${BUILD}"
  
elif [ "$ARTIFACTS_REPO" = "local" ] ; then
  #TODO: add local artifacts support
  echo "not supported"
fi

echo_env_var KUBE_APISERVER_ARTIFACT="${BASE_URL}/bin/linux/amd64/kube-apiserver" "${ENVS_FILE}"
echo_env_var KUBE_CONTROLLER_MANAGER_ARTIFACT="${BASE_URL}/bin/linux/amd64/kube-controller-manager" "${ENVS_FILE}"
echo_env_var CLOUD_CONTROLLER_MANAGER_ARTIFACT="${BASE_URL}/bin/linux/amd64/cloud-controller-manager" "${ENVS_FILE}"
echo_env_var KUBE_SCHEDULER_ARTIFACT="${BASE_URL}/bin/linux/amd64/kube-scheduler" "${ENVS_FILE}"
echo_env_var KUBELET_ARTIFACT="${BASE_URL}/bin/linux/amd64/kubelet" "${ENVS_FILE}"
echo_env_var KUBE_PROXY_ARTIFACT="${BASE_URL}/bin/linux/amd64/kube-proxy" "${ENVS_FILE}"
echo_env_var KUBECTL_ARTIFACT="${BASE_URL}/bin/linux/amd64/kubectl" "${ENVS_FILE}"
echo_env_var KUBETEST_ARTIFACT="${BASE_URL}/kubernetes-test.tar.gz" "${ENVS_FILE}"
echo_env_var KUBERNETES_ARTIFACT="${BASE_URL}/kubernetes.tar.gz" "${ENVS_FILE}"
echo_env_var TESTGRID_UPLOAD="/upload" "${ENVS_FILE}"
echo_env_var GCLOUD_ARTIFACT="https://storage.googleapis.com/cloud-sdk-release/google-cloud-sdk-0.9.83-linux-x86_64.tar.gz" "${ENVS_FILE}"

# gcr only store released version kube-proxy container
# v1.13.0-alpha.0.839+ef741c3038bb26 -> v1.13.0-alpha.0
KUBE_PROXY=$(echo "${BUILD}" | sed 's|\(.*\)\.\(.*+.*\)|\1|')
echo_env_var KUBE_PROXY_TAG="${KUBE_PROXY}" "${ENVS_FILE}"
