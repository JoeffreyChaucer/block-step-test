#!/bin/bash
set -euo pipefail



#echo "$BUILDKITE_COMMIT"

#echo "$BUILDKITE_AGENT_DEBUG"

#echo "$BUILDKITE_PULL_REQUEST_BASE_BRANCH"



#git diff --stat "$BUILDKITE_PULL_REQUEST_BASE_BRANCH".."$BUILDKITE_COMMIT"


#if ! git diff --name-only "$BUILDKITE_PULL_REQUEST_BASE_BRANCH".."$BUILDKITE_COMMIT" | grep -qvE '(.md)'
#then
#    echo "Only doc files were updated, not running the CI."
#    exit
#fi


#echo "Running pr-validation pipeline."

#echo "$BUILDKITE_PULL_REQUEST_BASE_BRANCH"
#echo "$BUILDKITE_PULL_REQUEST_DRAFT"

echo "steps:"

#if [ "$BUILDKITE_PULL_REQUEST_BASE_BRANCH" == "develop" ] || [ "$BUILDKITE_PULL_REQUEST_BASE_BRANCH" == "main" ];
#then
#echo " - command: buildkite-agent pipeline upload .buildkite/pipeline.yml"
#echo "  - command: \"echo Deploy!\""
#echo "    label: \":rocket:\""
#echo "  - command: \"echo Deploy2\""
#echo "    label: \":rocket:\""
#fi

if ! git diff --name-only main.."$BUILDKITE_COMMIT" | grep -qvE '(.md)'
then
    
    echo "  - command: \"echo Only doc files were updated, not running the CI.\""
    echo "    label: \":rocket:\""
fi



if [[ "$BUILDKITE_BRANCH" == "main" ]]; then
    echo "  - wait"
    echo "  - command: \"echo Deploy!\""
    echo "    label: \":rocket:\""
fi
