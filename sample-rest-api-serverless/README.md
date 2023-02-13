# Use Cloud Run Service from Apigee Proxy using Apigee Maven plugin and Cloud Build

This sample demonstrates how to use Cloud Run Service from Apigee Proxy using Cloud Build.

## Prerequisites
1. [Provision Apigee X](https://cloud.google.com/apigee/docs/api-platform/get-started/provisioning-intro)
2. Access to deploy proxies to Apigee, deploy Cloud Run and trigger Cloud Build
3. Configure [external access](https://cloud.google.com/apigee/docs/api-platform/get-started/configure-routing#external-access) for API traffic to your Apigee X instance
4. Make sure the following tools are available in your terminal's $PATH (Cloud Shell has these pre-configured)
    * [gcloud SDK](https://cloud.google.com/sdk/docs/install)
    * unzip
    * curl
    * jq
    * npm

## (QuickStart) Setup using CloudShell

Use the following GCP CloudShell tutorial, and follow the instructions.

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.png)](https://ssh.cloud.google.com/cloudshell/open?cloudshell_git_repo=https://github.com/ra2085/apigee-usecase-mashup&cloudshell_git_branch=main&cloudshell_workspace=.&cloudshell_tutorial=sample-rest-api-serverless/docs/cloudshell-tutorial.md)

## Setup instructions

1. Clone the apigee-usecase-mashup repo, and switch the sample-rest-api-serverless directory

```bash
git clone https://github.com/ra2085/apigee-usecase-mashup
cd sample-rest-api-serverless
```

2. Edit the `env.sh` and configure the ENV vars

* `PROJECT` the project where your Apigee organization is located
* `APIGEE_HOST` the externally reachable hostname of the Apigee environment group that contains APIGEE_ENV
* `APIGEE_ENV` the Apigee environment where the demo resources should be created
* `CLOUD_RUN_REGION` the region to deploy cloud run service.

Now source the `env.sh` file

```bash
source ./env.sh
```

3. Enable the Cloud Build API, IAM API, Cloud Run API and Container Registry API. Assign Apigee Org admin, Cloud Run Admin, Service Account User and Admin role to the Cloud Build service account

```bash
gcloud services enable iam.googleapis.com cloudbuild.googleapis.com run.googleapis.com containerregistry.googleapis.com

gcloud projects add-iam-policy-binding "$PROJECT" \
  --member="serviceAccount:$CLOUD_BUILD_SA" \
  --role="roles/apigee.admin"

gcloud projects add-iam-policy-binding "$PROJECT_ID" \
  --member="serviceAccount:$CLOUD_BUILD_SA" \
  --role="roles/run.admin"

gcloud projects add-iam-policy-binding "$PROJECT_ID" \
  --member="serviceAccount:$CLOUD_BUILD_SA" \
  --role="roles/iam.serviceAccountUser"

gcloud projects add-iam-policy-binding "$PROJECT_ID" \
  --member="serviceAccount:$CLOUD_BUILD_SA" \
  --role="roles/iam.serviceAccountAdmin"
```

4. Trigger the build

```bash
gcloud builds submit --config cloudbuild.yaml . \
    --substitutions="_SERVICE=$CLOUD_RUN_SERVICE","_REGION=$CLOUD_RUN_REGION","_APIGEE_TEST_ENV=$APIGEE_ENV"
```

## Test the APIs

You can test the API call to make sure the deployment was successful

1. Set the `API_KEY` environment variable with the output value from the previous step

```
API_KEY=REPLACE_WITH_API_KEY
```
2. Execute the test command

```sh
curl --location --request GET "https://$APIGEE_HOST/v1/samples/rest-api-serverless" --header "x-api-key: $API_KEY" -v
```

## Cleanup

If you want to clean up the artifacts from this example in your Apigee Organization, first source your `env.sh` script, and then run

```bash
./clean-up-cloud-run.sh
```
