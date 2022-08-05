#!/bin/bash

GH_OWNER=$GH_OWNER
GH_REPOSITORY=$GH_REPOSITORY

RUNNER_SUFFIX=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 5 | head -n 1)
RUNNER_NAME="ephemeral-runner"


cd /home/docker/actions-runner

#GH_TOKEN = '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'

#REG_TOKEN=$(curl -sX POST -H "Accept: application/vnd.github+json" -H "Authorization: token ${GH_TOKEN}" https://api.github.com/enterprises/ENTERPRISE/actions/runners/registration-token | jq .token --raw-output)
#REG_TOKEN = "AAAEF7UAWKUNEWVYVK5RFUTC5T7AA"
#./config.sh --unattended --url https://github.boschdevcloud.com/${GH_OWNER}/${GH_REPOSITORY} --token ${REG_TOKEN} --name ${RUNNER_NAME} --ephemeral
./config.sh --unattended --url https://github.boschdevcloud.com/HydraulicHubPoC/test_ephemeral_runner --token AAAEF7RS6O7KQHZTUPKAX5LC5UBPY --name ${RUNNER_NAME} --ephemeral

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --unattended --token ${REG_TOKEN}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!
