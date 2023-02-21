# Sample to use SAML Assertions in Apigee 

This sample demonstrates how to create and validate in Apigee signed SAML assertions.

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

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.png)](https://ssh.cloud.google.com/cloudshell/open?cloudshell_git_repo=https://github.com/ra2085/apigee-usecase-mashup&cloudshell_git_branch=main&cloudshell_workspace=.&cloudshell_tutorial=sample-saml-auth/docs/cloudshell-tutorial.md)

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

Now source the `env.sh` file

```bash
source ./env.sh
```

## Deploy Apigee components

Next, let's create and deploy the Apigee resources.

```sh
./deploy-ws-security.sh
```

## Test the APIs

You can test the API call to make sure the deployment was successful

1. Obtain an inspect a signed SAML Assertion

```sh
curl --location --request POST "https://$APIGEE_HOST/v1/samples/saml-auth/generate-saml" --header 'Content-Type: application/xml' --data-raw "<soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:examples:helloservice\"><soapenv:Header/><soapenv:Body><urn:sayHello soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"><firstName xsi:type=\"xsd:string\">John Doe</firstName></urn:sayHello></soapenv:Body></soapenv:Envelope>"
```

2. Store the a signed SAML assertion in an environment variable

```sh
SIGNED_ASSERTION=$(curl --location --request POST "https://$APIGEE_HOST/v1/samples/saml-auth/generate-saml" --header 'Content-Type: application/xml' --data-raw "<soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:examples:helloservice\"><soapenv:Header/><soapenv:Body><urn:sayHello soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"><firstName xsi:type=\"xsd:string\">John Doe</firstName></urn:sayHello></soapenv:Body></soapenv:Envelope>")
```

3. Verify the signed SAML assertion

```sh
curl --location --request POST "https://$APIGEE_HOST/v1/samples/saml-auth/validate-saml" --header 'Content-Type: application/xml' --data-raw "$SIGNED_ASSERTION"
```

Notice the `200 OK response code` in the response.

## Cleanup

If you want to clean up the artifacts from this example in your Apigee Organization, first source your `env.sh` script, and then run

```bash
./clean-up-ws-security.sh
```
