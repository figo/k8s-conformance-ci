# !/bin/sh

# input: none
# output: artifacts as enviroment variables


# $CNI_ARTIFACT
# $ETCD_ARTIFACT

# $KUBE_APISERVER_ARTIFACT
# $KUBE_CONTROLLER_MANAGER_ARTIFACT
# $KUBE_SCHEDULER_ARTIFACT
# $KUBELET_ARTIFACT
# $KUBE_PROXY_ARTIFACT
# $KUBE_PROXY_TAG

# $KUBECTL_ARTIFACT
# $KUBETEST_ARTIFACT


K8S_RELEASE_DEV_BASE_URL="https://storage.googleapis.com/kubernetes-release-dev"
BUILD=$(curl ${K8S_RELEASE_DEV_BASE_URL}/ci/latest.txt)
echo ${BUILD}

ENVS_FILE=$(mktemp)

# echo_env_var writes an environment variable and its value to
# ENVS_FILE as long as the value is not empty
echo_env_var() {
  if [ -n "$(echo "${1}" | sed 's/^[^=]*=//g')" ]; then 
    echo "${1}" >> "${ENVS_FILE}"
  fi
}

echo_env_var KUBE_APISERVER_ARTIFACT="${K8S_RELEASE_DEV_BASE_URL}/ci/${BUILD}/bin/linux/amd64/kube-apiserver"
echo_env_var KUBE_CONTROLLER_MANAGER_ARTIFACT="${K8S_RELEASE_DEV_BASE_URL}/ci/${BUILD}/bin/linux/amd64/kube-controller-manager"
echo_env_var KUBE_SCHEDULER_ARTIFACT="${K8S_RELEASE_DEV_BASE_URL}/ci/${BUILD}/bin/linux/amd64/kube-scheduler"
echo_env_var KUBELET_ARTIFACT="${K8S_RELEASE_DEV_BASE_URL}/ci/${BUILD}/bin/linux/amd64/kubelet"
echo_env_var KUBE_PROXY_ARTIFACT="${K8S_RELEASE_DEV_BASE_URL}/ci/${BUILD}/bin/linux/amd64/kube-proxy"
echo_env_var KUBECTL_ARTIFACT="${K8S_RELEASE_DEV_BASE_URL}/ci/${BUILD}/bin/linux/amd64/kubectl"
echo_env_var KUBETEST_ARTIFACT="${K8S_RELEASE_DEV_BASE_URL}/ci/${BUILD}/kubernetes-test.tar.gz"
echo_env_var KUBE_PROXY_TAG="${BUILD}"

echo ${ENVS_FILE}
