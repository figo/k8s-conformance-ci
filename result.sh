#!/bin/sh

# it assuming the gcloud auth key file located at ${TESTGRID_UPLOAD}/key

if [ "${K8S_VERSION_BASE}" = "" ]
then 
  K8S_VERSION_BASE="ci"
  K8S_VERSION="latest"
else
  K8S_VERSION="v${K8S_VERSION}"
fi


cd "${TESTGRID_UPLOAD}" || exit 1
python /cncf/upload_e2e.py --junit="${CONFORMANCE_LOG_DIR}"/artifacts/junit_*.xml \
--log="${CONFORMANCE_LOG_DIR}"/e2e.log \
--bucket=gs://k8s-conformance-cloud-provider-vsphere/experimental/head/"${K8S_VERSION_BASE}"/"${K8S_VERSION}" \
--key-file="${TESTGRID_UPLOAD}"/key

echo "test upload finished"
