#!/bin/sh
set -e

CONFORMANCE_LOG_DIR="${1}"

# get the right version of kubectl
# echo ${KUBECTL_ARTIFACT}
# curl -sSL -o /usr/loca/bin/kubectl ${KUBECTL_ARTIFACT}
# chmod +x /usr/local/bin/kubectl

mkdir "${CONFORMANCE_LOG_DIR}/_artifacts"

# get the test artifact
curl -sSL ${KUBETEST_ARTIFACT} | tar xvz

# launch conformance tests
export KUBECONFIG=${KUBECONFIG}
export KUBERNETES_CONFORMANCE_TEST=y
cd kubernetes
go run ./hack/e2e.go -- --provider=skeleton \
--test --test_args="--ginkgo.focus=\[Conformance\]" \
--dump=${CONFORMANCE_LOG_DIR}/_artifacts \
--check-version-skew=false | tee ${CONFORMANCE_LOG_DIR}/e2e.log || true

