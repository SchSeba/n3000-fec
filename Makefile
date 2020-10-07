# Registry used to push container images under it
REGISTRY ?= myregistry.com:5000


# Kernel section
export KERNEL_TYPE ?= kernel-rt
export KERNEL_VERSION_MAJOR ?= 4.18.0
export KERNEL_VERSION_MINOR ?= 193.19.1.rt13.70.el8_2
export KERNEL_ARCH ?= x86_64
export KERNEL_VERSION ?= ${KERNEL_VERSION_MAJOR}-${KERNEL_VERSION_MINOR}.${KERNEL_ARCH}

export PACKAGE_BASE_URL ?= http://example.com
export PACKAGE_URL ?= ${PACKAGE_BASE_URL}/${KERNEL_VERSION_MAJOR}/${KERNEL_VERSION_MINOR}/${KERNEL_ARCH}


# OPAE section
export OPAE_RPM_NAME ?= opae-intel-fpga-driver-2.0.1-9.x86_64.rpm
export OPAE_MODULE_NAME ?= opae-intel-fpga-driver
export OPAE_MODULE_VERSION ?= 2.0.1-9

# Image URL to use all building/pushing image targets
TAG ?= latest

export DRIVER_CONTAINER ?= ${REGISTRY}/driver-container:${TAG}

export CONTAINER_BIN ?= docker

# Build the docker image
.PHONY: docker-build
docker-build:
	./hack/build-setup.sh

# Push the docker image
.PHONY: docker-push
docker-push:
	${CONTAINER_BIN} push ${DRIVER_CONTAINER}

.PHONY: deploy
deploy:
	./hack/deploy-setup.sh