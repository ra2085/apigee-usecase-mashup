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


echo "Installing apigeecli"
curl -s https://raw.githubusercontent.com/apigee/apigeecli/master/downloadLatest.sh | bash
export PATH=$PATH:$HOME/.apigeecli/bin

TOKEN=$(gcloud auth print-access-token)

echo "Creating ServiceNow Credentials properties file..."
apigeecli res create --name servicenow --type properties --respath ./servicenow.properties --org "$PROJECT_ID" --env "$APIGEE_ENV" --token "$TOKEN"

echo "Importing and deploying the servicenow-sec shared flow..."
REV_SF=$(apigeecli sharedflows create -f ./sharedflowbundle -n servicenow-sec --org "$PROJECT_ID" --token "$TOKEN" --disable-check | jq ."revision" -r)
apigeecli sharedflows deploy --name servicenow-sec --ovr --rev "$REV_SF" --org "$PROJECT_ID" --env "$APIGEE_ENV" --token "$TOKEN"

echo "Importing and Deploying Apigee servicenow-incident-v1 proxy..."
REV=$(apigeecli apis create bundle -f ./apiproxy -n servicenow-incident-v1 --org "$PROJECT_ID" --token "$TOKEN" --disable-check | jq ."revision" -r)
apigeecli apis deploy --wait --name servicenow-incident-v1 --ovr --rev "$REV" --org "$PROJECT_ID" --env "$APIGEE_ENV" --token "$TOKEN"


echo " "
echo "All the Apigee artifacts are successfully deployed!"
echo " "