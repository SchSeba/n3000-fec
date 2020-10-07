#!/bin/bash

# set -euxo pipefail
pushd ./bindata/manifests/oot-daemon
      envsubst< daemonset.yaml | oc apply --validate=false -f -
  done
popd
