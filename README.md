# Kubernetes conformance CI 
The CI that run kubernetes conformance tests on cluster

## Concept
The CI has four stages:

| Stage  | Description |
|------|-------------|
| Artifacts | K8s artifacts can be fetched from https://storage.googleapis.com/kubernetes-release/-dev or from local |
| Provision | Provision k8s cluster using artifacts | 
| Provider Setup | Setup cloud provider |
| Test | Run conformance tests|
| Result | Make test result available to testgrid or local |

#### Artifacts
define the location of k8s artifacts
```
# fetch latest version by  
./hack/get-build.sh -v ci/latest
or
gsutil ls gs://kubernetes-release-dev/ci/k8s-beta.txt
gsutil ls gs://kubernetes-release-dev/ci/k8s-stable1.txt
gsutil ls gs://kubernetes-release-dev/ci/k8s-stable2.txt
gsutil ls gs://kubernetes-release-dev/ci/k8s-stable3.txt
gsutil ls gs://kubernetes-release-dev/ci/latest-1.10.txt
gsutil ls gs://kubernetes-release-dev/ci/latest-1.11.txt
gsutil ls gs://kubernetes-release-dev/ci/latest-1.12.txt
gsutil ls gs://kubernetes-release-dev/ci/latest-1.13.txt
gsutil ls gs://kubernetes-release-dev/ci/latest-1.8.txt
gsutil ls gs://kubernetes-release-dev/ci/latest-1.9.txt
gsutil ls gs://kubernetes-release-dev/ci/latest-1.txt
gsutil ls gs://kubernetes-release-dev/ci/latest-bazel-1.10.txt
gsutil ls gs://kubernetes-release-dev/ci/latest-bazel-1.11.txt
gsutil ls gs://kubernetes-release-dev/ci/latest-bazel-1.12.txt
gsutil ls gs://kubernetes-release-dev/ci/latest-bazel-1.8.txt
gsutil ls gs://kubernetes-release-dev/ci/latest-bazel-1.9.txt
gsutil ls gs://kubernetes-release-dev/ci/latest-bazel.txt
gsutil ls gs://kubernetes-release-dev/ci/latest-green.txt
gsutil ls gs://kubernetes-release-dev/ci/latest.txt
```

```
artifacts.sh
```

#### Provision
Provision cluster using artifacts
```
provision.sh 
```

#### Provider Setup
Setup cloud provider (out of tree by default)
```
ccm.sh 
```


#### Test
get kubetest and launch kubernetes conformance tests
```
conformance.sh
```

#### Result
make test result availabe to testgrid or local
```
result.sh
```

## HOWTO Build container
TODO: need to handle versioning
```
make build

```

## HOWTO Upload container
```
make upload
```

## HOWTO Run container
gcloud keyfile folder needed be bind mounted   
for uploading result to testgrid;  
TODD: will remove DNS_SERVER later.  
```
export DNS_SERVER=192.168.2.99 && \
docker pull luoh/k8s-conformance:latest && \
docker run \
  --rm \
  --dns $DNS_SERVER --dns 8.8.8.8 \
  -v ${PWD}:/upload \
  -e VSPHERE_SERVER=$VSPHERE_SERVER \
  -e VSPHERE_USER=$VSPHERE_USER \
  -e VSPHERE_PASSWORD=$VSPHERE_PASSWORD \
  -e TF_VAR_etcd_server=$DNS_SERVER:2379 \
  -e TF_VAR_discovery_nameserver=$DNS_SERVER \
  -ti luoh/k8s-conformance:latest
```





