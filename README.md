# Kubernetes conformance CI 
The CI that run kubernetes conformance tests on cluster, 

## Concept
The CI has four stages:

| Stage  | Description |
|------|-------------|
| Artifacts | K8s artifacts can be fetched from https://storage.googleapis.com/kubernetes-release/-dev or from local |
| Provision | Provision k8s cluster using artifacts from build | 
| Test | Run conformance tests|
| Result | Make test result available to testgrid or local |

### Artifacts
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

### Provision
Provision cluster using artifacts from build
```
provision.sh 
```

### Test
get kubetest and launch kubernetes conformance tests
```
conformance.sh
```

### Result
make test result availabe to testgrid or local
```
result.sh
```






