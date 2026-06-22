#!/bin/bash

source scripts/install_haskell.env
if [ $# -ne 1 ]; then
  echo "Usage: $0 <ghc version>"
  exit 1
fi
BOOTSTRAP_HASKELL_GHC_VERSION="$1"

IMAGE_NAME="bjing/haskell-dev-container"
VERSIONED_IMAGE_NAME="${IMAGE_NAME}:ghc-${BOOTSTRAP_HASKELL_GHC_VERSION}"
LATEST_IMAGE_NAME="${IMAGE_NAME}:latest"

# Build
docker build \
  --build-arg MINIMAL_INSTALL=${BOOTSTRAP_HASKELL_MINIMAL} \
  --build-arg NONINTERACTIVE=${BOOTSTRAP_HASKELL_NONINTERACTIVE} \
  --build-arg GHC_VERSION=${BOOTSTRAP_HASKELL_GHC_VERSION} \
  --build-arg CABAL_VERSION=${BOOTSTRAP_HASKELL_CABAL_VERSION} \
  --build-arg INSTALL_STACK=${BOOTSTRAP_HASKELL_INSTALL_STACK} \
  --build-arg INSTALL_HLS=${BOOTSTRAP_HASKELL_INSTALL_HLS} \
  --build-arg ADJUST_BASHRC=${BOOTSTRAP_HASKELL_ADJUST_BASHRC} \
  -t ${LATEST_IMAGE_NAME} .


# Tag the image with the versioned tag as well
docker tag ${LATEST_IMAGE_NAME} "${VERSIONED_IMAGE_NAME}"

#docker push "${VERSIONED_IMAGE_NAME}"
#docker push "${LATEST_IMAGE_NAME}"
