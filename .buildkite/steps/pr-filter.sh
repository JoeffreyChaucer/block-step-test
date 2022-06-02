#!/bin/bash
set -euo pipefail


echo "steps:"


echo "$BUILDKITE_COMMIT"

echo "$BUILDKITE_PULL_REQUEST_BASE_BRANCH"


git diff --stat "$BUILDKITE_PULL_REQUEST_BASE_BRANCH".."$BUILDKITE_COMMIT"

if ! git diff --name-only "$BUILDKITE_PULL_REQUEST_BASE_BRANCH".."$BUILDKITE_COMMIT" | grep -qvE '(.md)'
then
    echo "Only doc files were updated, not running the CI."
    exit
fi


echo "Running pr-validation pipeline."

echo "$BUILDKITE_PULL_REQUEST_BASE_BRANCH"
echo "$BUILDKITE_PULL_REQUEST_DRAFT"


if [ "$BUILDKITE_PULL_REQUEST_BASE_BRANCH" == "develop" ] || [ "$BUILDKITE_PULL_REQUEST_BASE_BRANCH" == "main" ] || [[ "$BUILDKITE_PULL_REQUEST_BASE_BRANCH" =~ /^release\// ]] || [ "$BUILDKITE_PULL_REQUEST_BASE_BRANCH" == "marvel/develop" ] || [ "$BUILDKITE_PULL_REQUEST_BASE_BRANCH" == "test_ci" ] &&  ! BUILDKITE_PULL_REQUEST_DRAFT;
then
    echo " - command: buildkite-agent pipeline upload .buildkite/pipeline.yml"
fi
