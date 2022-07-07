#!/bin/bash
VERSION=$(git describe)
echo Building version $VERSION
go build -ldflags "-X github.com/botlabs-gg/yagpdb/v2/common.VERSION=${VERSION}"