KUBERNETES_VERSION=1.16.0
DEBIAN_BASE=k8s.gcr.io/debian-base-amd64:0.4.1

KUBE_CONFORMANCE_IMAGE="docker.io/zlabjp/kube-conformance:$(KUBERNETES_VERSION)"

.PHONY: build
build:
		DOCKER_BUILDKIT=1 docker build --build-arg DEBIAN_BASE=$(DEBIAN_BASE) --build-arg KUBERNETES_VERSION=$(KUBERNETES_VERSION) -t $(KUBE_CONFORMANCE_IMAGE) .

.PHONY: push
push:
		docker push $(KUBE_CONFORMANCE_IMAGE)

.PHONY: test
test:
		KUBE_CONFORMANCE_IMAGE=$(KUBE_CONFORMANCE_IMAGE) ./hack/run-e2e.sh
