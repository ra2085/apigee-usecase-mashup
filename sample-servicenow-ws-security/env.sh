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

export PROJECT_ID="<GCP_PROJECT_ID>" # e.g. "my-project-id"
export APIGEE_HOST="<APIGEE_DOMAIN_NAME>" # e.g. "34-149-156-6.nip.io"
export APIGEE_ENV="<APIGEE_ENVIRONMENT_NAME>" # e.g. "prod"

export SERVICENOW_INSTANCE_HOSTNAME="<SERVICENOW_INSTANCE_HOSTNAME>" # e.g. "servicenow-instance-name.servicenow.com"

gcloud config set project $PROJECT_ID
sed -i "s/SERVICENOWINSTANCEHOSTNAME/$SERVICENOW_INSTANCE_HOSTNAME/g" ./incident.wsdl
