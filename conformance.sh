#!/bin/sh

# read variables from enviroment file
ENV_FILE="${1}"
while read -r line; do declare $line; done <${ENV_FILE}

# get the right version of kubectl
curl -sSL -o /usr/loca/bin/kubectl ${KUBECTL_ARTIFACT}
chmod +x /usr/local/bin/kubectl

# get the test artifact
TEST_DIR=$(mktemp)
cd ${TEST_DIR}
curl ${KUBETEST_ARTIFACT} | tar xvz

# launch conformance tests
export KUBECONFIG=${KUBECONFIG}
export KUBERNETES_CONFORMANCE_TEST=y

go run ./kubernetes/hack/e2e.go \ 
-- --provider=skeleton \
--test \
--test_args="--ginkgo.focus=\[Conformance\]" \
--dump=/data/_artifacts | tee /data/e2e.log
