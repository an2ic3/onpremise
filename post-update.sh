#!/usr/bin/env bash
set -e

VERSION=$1

if [[ ${VERSION} == "" ]]; then
  echo "Please specify a version"
  exit
else
  echo "Updating to ${VERSION}"
fi

echo "Applying new version"
sed -i -E "s/AN2IC3_VERSION=(.*)/AN2IC3_VERSION=${VERSION}/" .env
