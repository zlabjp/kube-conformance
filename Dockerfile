# Copyright 2019, Z Lab Corporation. All rights reserved.
# Copyright 2019, kube-conformance contributors
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.

ARG DEBIAN_BASE

FROM ${DEBIAN_BASE} AS base
ARG KUBERNETES_VERSION
ENV KUBERNETES_VERSION=v${KUBERNETES_VERSION}
RUN set -x && \
    apt-get update -qq && \
    apt-get install -qq -y wget

FROM base AS kubernetes-test
RUN set -x && \
    wget -q "https://storage.googleapis.com/kubernetes-release/release/${KUBERNETES_VERSION}/kubernetes-test-linux-amd64.tar.gz" && \
    tar xvzf kubernetes-test-linux-amd64.tar.gz

FROM base AS kubectl
RUN set -x && \
    wget -q -O kubectl "https://storage.googleapis.com/kubernetes-release/release/${KUBERNETES_VERSION}/bin/linux/amd64/kubectl" && \
    chmod +x kubectl

FROM ${DEBIAN_BASE}
COPY --from=kubernetes-test kubernetes/test/bin/e2e.test /usr/local/bin/
COPY --from=kubernetes-test kubernetes/test/bin/ginkgo /usr/local/bin/
COPY --from=kubectl kubectl /usr/local/bin/
