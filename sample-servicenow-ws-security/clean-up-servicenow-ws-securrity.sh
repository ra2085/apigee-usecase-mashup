#!/bin/bash

# Copyright 2023 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

if [ -z "$PROJECT_ID" ]; then
    echo "No PROJECT_ID variable set"
    exit
fi

if [ -z "$APIGEE_ENV" ]; then
    echo "No APIGEE_ENV variable set"
    exit
fi

echo "Undeploying servicenow-incident-v1 proxy"
REV=$(apigeecli envs deployments get --env "$APIGEE_ENV" --org "$PROJECT_ID" --token "$TOKEN" --disable-check | jq .'deployments[]| select(.apiProxy=="servicenow-incident-v1").revision' -r)
apigeecli apis undeploy --name servicenow-incident-v1 --env "$APIGEE_ENV" --rev "$REV" --org "$PROJECT_ID" --token "$TOKEN"

echo "Deleting proxy servicenow-incident-v1 proxy"
apigeecli apis delete --name servicenow-incident-v1 --org "$PROJECT_ID" --token "$TOKEN"

echo "Undeploying servicenow-sec sharedflow"
REV=$(apigeecli envs deployments get --env "$APIGEE_ENV" --org "$PROJECT_ID" --token "$TOKEN" --sharedflows true --disable-check | jq .'deployments[]| select(.apiProxy=="servicenow-sec").revision' -r)
apigeecli sharedflows undeploy --name servicenow-sec --env "$APIGEE_ENV" --rev "$REV" --org "$PROJECT_ID" --token "$TOKEN"

echo "Deleting proxy servicenow-sec sharedflow"
apigeecli sharedflows delete --name servicenow-sec --org "$PROJECT_ID" --token "$TOKEN"

echo "Deleting mock ServiceNow credentials property file..."
apigeecli res delete --org "$PROJECT_ID" --env "$APIGEE_ENV" --token "$TOKEN" --name servicenow --type properties

rm servicenow.properties