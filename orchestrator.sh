#!/bin/sh

source ./util.sh

TEST_DIR=$(mktemp -d)
echo "${TEST_DIR}"
NAME=$(hostname)
echo "${NAME}"

PROVISION_LOG_DIR="${TEST_DIR}/provision"
CONFORMANCE_LOG_DIR="${TEST_DIR}/conformance"
mkdir "${CONFORMANCE_LOG_DIR}"
ENV_FILE="${TEST_DIR}/enviroments"


# "ci-latest" or "release" or "local"
# if release been set, then ${K8S_VERSION} need be set to the version like 1.10, 1.11.
if [ "${K8S_VERSION_BASE}" = "" ]; then K8S_VERSION_BASE="ci-latest"; fi

# get all artifacts
source artifacts.sh "upstream-${K8S_VERSION_BASE}" "${ENV_FILE}" "${K8S_VERSION}"

# deploy kubernetes cluster using artifacts
./provision.sh "vsphere-deploy" "${NAME}" "file" "${PROVISION_LOG_DIR}"

# declare kubeconfig file location
echo_env_var KUBECONFIG="${PROVISION_LOG_DIR}/kubeconfig" "${ENV_FILE}"
echo_env_var CONFORMANCE_LOG_DIR="${CONFORMANCE_LOG_DIR}" "${ENV_FILE}"

# setup ccm
./ccm.sh || { echo 'ccm setup failed' ; exit 1; }

# deploy cni
./cni.sh || { echo 'cni deployment failed' ; exit 1; }

# run conformance tests
#./conformance.sh || { echo 'conformance test failed' ; exit 1; }

# post result
#./result.sh || { echo 'failed to upload test result' ; exit 1; }

# destroy kubernetes cluster
#./provision.sh "vsphere-destroy" "${NAME}" "file" "${PROVISION_LOG_DIR}"
