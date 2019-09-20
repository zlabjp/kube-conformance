# Kubernetes conformance tests

[![Actions Status](https://github.com/zlabjp/kube-conformance/workflows/CI/badge.svg)](https://github.com/zlabjp/kube-conformance/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](./LICENSE)

This is a container image to run Kubernetes end-to-end tests. It includes the `e2e.test` binary, and two command line tools, `kubectl` and `ginkgo`.

You can find available images on Docker Hub, on the [docker.io/zlabjp/kube-conformance](https://hub.docker.com/r/zlabjp/kube-conformance/tags) repository.

## How to use this image

Here is an example for running e2e tests for the CSI hostpath driver:

```bash
KUBECONFIG="${KUBECONFIG:-$HOME/.kube/config}"
docker run --init --rm -w "/workspace" -v "$KUBECONFIG:/config" -v "${PWD}:/workspace" docker.io/zlabjp/kube-conformance:1.15.3 \
  ginkgo -p \
    --focus='External.Storage.*csi-hostpath' \
    --skip='\[Feature:|\[Disruptive\]' \
    /usr/local/bin/e2e.test \
    -- \
    --kubeconfig=/config \
    --provider=local \
    --storage.testdriver=/workspace/hostpath-testdriver.yaml
```

See the following pages for more details on Kubernetes e2e tests:

- [End-to-End Testing in Kubernetes](https://github.com/kubernetes/community/blob/master/contributors/devel/sig-testing/e2e-tests.md)
- [Kubernetes End\-to\-end Testing for Everyone \- Kubernetes](https://kubernetes.io/blog/2019/03/22/kubernetes-end-to-end-testing-for-everyone/)
- https://github.com/kubernetes/kubernetes/tree/master/test/e2e/storage/external

## License

MIT
