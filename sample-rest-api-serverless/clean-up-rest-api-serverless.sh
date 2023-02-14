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

if [ -z "$PROJECT" ]; then
        echo "No PROJECT variable set"
        exit
fi

if [ -z "$APIGEE_ENV" ]; then
        echo "No APIGEE_ENV variable set"
        exit
fi

if [ -z "$APIGEE_HOST" ]; then
        echo "No APIGEE_HOST variable set"
        exit
fi

if [ -z "$CLOUD_RUN_SERVICE" ]; then
        echo "No CLOUD_RUN_SERVICE variable set"
        exit
fi

if [ -z "$CLOUD_RUN_REGION" ]; then
        echo "No CLOUD_RUN_REGION variable set"
        exit
fi

TOKEN=$(gcloud auth print-access-token)
SA_NAME=run-mock-target-sa

echo "Installing apigeecli"
curl -s https://raw.githubusercontent.com/apigee/apigeecli/master/downloadLatest.sh | bash
export PATH=$PATH:$HOME/.apigeecli/bin

echo "Deleting Developer App"
DEVELOPER_ID=$(apigeecli developers get --email rest-api-serverless_apigeesamples@acme.com --org "$PROJECT" --token "$TOKEN" --disable-check | jq .'developerId' -r)
apigeecli apps delete --id "$DEVELOPER_ID" --name rest-api-serverless-sample-app --org "$PROJECT" --token "$TOKEN"

echo "Deleting Developer"
apigeecli developers delete --email rest-api-serverless_apigeesamples@acme.com --org "$PROJECT" --token "$TOKEN"

echo "Deleting API Products"
apigeecli products delete --name rest-api-serverless-sample-product --org "$PROJECT" --token "$TOKEN"

echo "Undeploying sample-rest-api-serverless proxy"
REV=$(apigeecli envs deployments get --env "$APIGEE_ENV" --org "$PROJECT" --token "$TOKEN" --disable-check | jq .'deployments[]| select(.apiProxy=="sample-rest-api-serverless").revision' -r)
apigeecli apis undeploy --name sample-rest-api-serverless --env "$APIGEE_ENV" --rev "$REV" --org "$PROJECT" --token "$TOKEN"

echo "Deleting proxy sample-rest-api-serverless proxy"
apigeecli apis delete --name sample-rest-api-serverless --org "$PROJECT" --token "$TOKEN"

echo "Delete cloud run service"
gcloud --quiet run services delete "$CLOUD_RUN_SERVICE" --region="$CLOUD_RUN_REGION"

echo "Deleting service account"
gcloud --quiet iam service-accounts delete ${SA_NAME}@"${PROJECT}".iam.gserviceaccount.com

echo "Deleting mock config environment property set..."
apigeecli res delete --org "$PROJECT" --env "$APIGEE_ENV" --token "$TOKEN" --name mock_configuration --type properties

rm mock_configuration.properties