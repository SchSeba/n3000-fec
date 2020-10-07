#!/bin/bash

# set -euxo pipefail
pushd ./build/driver-container
  envsubst< Dockerfile.tmpl > Dockerfile
popd

echo "building driver container"
${CONTAINER_BIN} build . -t ${DRIVER_CONTAINER} -f ./build/driver-container/Dockerfile
