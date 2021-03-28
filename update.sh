#!/usr/bin/env bash
set -e

VERSION=$1

if [[ ${VERSION} == "" ]]; then
  echo "Please specify a version"
  exit
else
  echo "Updating to ${VERSION}"
fi

REMOTE=upstream
UPSTREAM=https://github.com/getsentry/onpremise.git

echo "Configuring remotes..."
if [[ $(git remote get-url "${REMOTE}" 2>&1) == "fatal: No such remote '${REMOTE}'" ]]; then
  git remote add "${REMOTE}" "${UPSTREAM}"
else
  git remote set-url "${REMOTE}" "${UPSTREAM}"
fi

echo "Fetching all remotes..."
git fetch --all > /dev/null

echo "Pulling remote changes..."
git pull --rebase > /dev/null

echo "Merging new version..."
git merge ${VERSION} > /dev/null

echo "Please solve all merge conflicts..."

bash post-update.sh "${VERSION}"
