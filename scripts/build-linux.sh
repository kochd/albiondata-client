#!/usr/bin/env bash

set -eo pipefail

sudo apt-get update && sudo apt-get install -y libpcap-dev patchelf

go build -ldflags "-s -w -X main.version=$GITHUB_REF_NAME" albiondata-client.go
ls -la

patchelf --replace-needed libpcap.so.0.8 libpcap.so albiondata-client

gzip -9 albiondata-client
mv albiondata-client.gz update-linux-amd64.gz
ls -la
