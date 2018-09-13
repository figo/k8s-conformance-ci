#!/bin/sh

# it assuming the gcloud auth key file located at ${TESTGRID_UPLOAD}/key

cd "${TESTGRID_UPLOAD}" || exit 1
python /cncf/upload_e2e.py --junit="${CONFORMANCE_LOG_DIR}"/artifacts/junit_*.xml \
--log="${CONFORMANCE_LOG_DIR}"/e2e.log \
--bucket=gs://k8s-conformance-cloud-provider-vsphere \
--key-file="${TESTGRID_UPLOAD}"/key

echo "test upload finished"
