#!/bin/bash

export HOME=/tmp/home
mkdir -p "$HOME/.docker"
cd "$HOME" || exit 1

# log function
log_file="${ARTIFACT_DIR}/mirror.log"
log() {
    local ts
    ts=$(date --iso-8601=seconds)
    echo "$ts" "$@" | tee -a "$log_file"
}

# Get current date
current_date=$(date +%F)
log "INFO Current date is $current_date"

# Get IMAGE_REPO
log "INFO Image repo is $IMAGE_REPO"

git clone https://github.com/opendatahub-io/opendatahub-operator.git
cd opendatahub && git checkout update-sdk

log "Install image from master branch of the operator"
make deploy

log "Verify Operator e2e pass"
make e2e-test