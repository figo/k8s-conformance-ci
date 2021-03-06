#!/bin/sh
set -e

mkdir "${CONFORMANCE_LOG_DIR}/_artifacts"

# get the test artifact
curl -sSL "${KUBETEST_ARTIFACT}" | tar xvz
curl -sSL "${KUBERNETES_ARTIFACT}" | tar xvz

# launch conformance tests
export KUBECONFIG="${KUBECONFIG}"
export KUBERNETES_CONFORMANCE_TEST=y
export SKIP="Alpha|Kubectl|\[(Disruptive|Feature:[^\]]+|Flaky)\]"
export TEST="\[Conformance\]"

cd kubernetes

# get the right version of kubectl
echo "${KUBECTL_ARTIFACT}"
curl -sSL -o ./platforms/linux/amd64/kubectl "${KUBECTL_ARTIFACT}"
chmod +x ./platforms/linux/amd64/kubectl

go run ./hack/e2e.go -- --provider=skeleton \
--test --test_args="--ginkgo.focus=${TEST} --ginkgo.skip=${SKIP}" \
--dump="${CONFORMANCE_LOG_DIR}"/artifacts \
--check-version-skew=false | tee "${CONFORMANCE_LOG_DIR}"/e2e.log || true
