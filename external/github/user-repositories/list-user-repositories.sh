#!/usr/bin/env bash

set -e

exec 3>&1 # make stdout available as fd 3 for the result
exec 1>&2 # redirect all output to stderr for logging

PATH=/usr/local/bin:$PATH

TMP=$(mktemp -d ${TMPDIR:=/tmp}/$(basename $0).XXXXXX)
TF_QUERY=${TMP}/query.json
GH_RESPONSE=${TMP}/github-response.json

cat > ${TF_QUERY} <&0

eval "$(jq -r '@sh "GITHUB_BASE_URL=\(.base_url) GITHUB_USERNAME=\(.username) GITHUB_TOKEN=\(.token)"' ${TF_QUERY})"

http --body --ignore-stdin --json \
    GET ${GITHUB_BASE_URL?required}/users/${GITHUB_USERNAME?required}/repos \
    "Authorization:token ${GITHUB_TOKEN?required}" \
> ${GH_RESPONSE}

jq -n "{
  repositories: \"$(jq -r '.[].name' ${GH_RESPONSE} | sort | xargs)\"
}" >&3
