#!/usr/bin/env bash

set -e -o pipefail; [[ -n "$DEBUG" ]] && set -x

KUBECONFIG="${KUBECONFIG:-$HOME/.kube/config}"
docker run --init --rm --net host -v "$KUBECONFIG:/config" "${KUBE_CONFORMANCE_IMAGE}" \
  ginkgo -p \
    --focus='Kubectl client.*should support exec$' \
    /usr/local/bin/e2e.test \
    -- \
    --kubeconfig=/config \
    --provider=local
