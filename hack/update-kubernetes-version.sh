#!/usr/bin/env bash

set -e -o pipefail; [[ -n "$DEBUG" ]] && set -x

kubernetes_version="$1"

if [[ -z "$kubernetes_version" ]]; then
  echo "Usage: $0 <kubernetes-version> (e.g. 1.15.3)" >&2
  exit 1
fi

sed -i -e "s#kube-conformance:[0-9.]\+#kube-conformance:$kubernetes_version#" README.md
sed -i -e "s/KUBERNETES_VERSION=[0-9\.]\+/KUBERNETES_VERSION=$kubernetes_version/" Makefile
sed -i -e "s#image: kindest/node:v[0-9\.]\+#image: kindest/node:v${kubernetes_version}#" .github/workflows/main.yaml
