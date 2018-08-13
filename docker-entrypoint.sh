#!/usr/bin/env sh

# This script is mainly based on https://about.gitlab.com/2017/09/05/how-to-automatically-create-a-new-mr-on-gitlab-with-gitlab-ci/

HOST=${HOST:="https://gitlab.com/api/v4/"}
REMOVE_SOURCE_BRANCH=${REMOVE_SOURCE_BRANCH:=true}
SQUASH=${SQUASH:=true}
TARGET_BRANCH=${TARGET_BRANCH:=master}

BODY="{
    \"assignee_id\":\"${GITLAB_USER_ID}\",
    \"id\": ${CI_PROJECT_ID},
    \"remove_source_branch\": ${REMOVE_SOURCE_BRANCH},
    \"source_branch\": \"${CI_COMMIT_REF_NAME}\",
    \"squash\": ${SQUASH},
    \"target_branch\": \"${TARGET_BRANCH}\",
    \"title\": \"WIP: ${CI_COMMIT_REF_NAME}\"
}";

LISTMR=`curl --silent "${HOST}projects/${CI_PROJECT_ID}/merge_requests?state=opened" --header "PRIVATE-TOKEN:${PRIVATE_TOKEN}"`;
COUNTBRANCHES=`echo ${LISTMR} | grep -o "\"source_branch\":\"${CI_COMMIT_REF_NAME}\"" | wc -l`;

if [ ${COUNTBRANCHES} -eq "0" ]; then
    curl --silent -X POST "${HOST}projects/${CI_PROJECT_ID}/merge_requests" \
        --header "PRIVATE-TOKEN:${PRIVATE_TOKEN}" \
        --header "Content-Type: application/json" \
        --data "${BODY}";

    echo "Opened a new merge request: WIP: ${CI_COMMIT_REF_NAME} and assigned to you.";
    exit;
fi

echo "There is an MR currently opened, skipping.";
