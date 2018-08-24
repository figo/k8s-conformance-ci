#!/bin/sh
set -e

source ./util.sh

TEST_DIR=$(mktemp -d)
echo "${TEST_DIR}"
NAME=$(hostname)
echo "${NAME}"

PROVISION_LOG="${TEST_DIR}/provision"
CONFORMANCE_LOG="${TEST_DIR}/conformance"
ENV_FILE="${TEST_DIR}/enviroments"

# get all artifacts
source artifacts.sh "upstream-latest" "${ENV_FILE}"

# deploy kubernetes cluster using artifacts
source provision.sh "vsphere-deploy" "${NAME}" "file" ${PROVISION_LOG}

# declare kubeconfig file location
echo_env_var KUBECONFIG="${PROVISION_LOG}/kubeconfig" "${ENV_FILE}"

# run conformance tests
source conformance.sh "${CONFORMANCE_LOG}"

# post result
./result.sh "${CONFORMANCE_LOG}/e2e.log"
