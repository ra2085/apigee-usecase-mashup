# Sample to use WS-Security in Apigee 

This sample demonstrates how to create or validate in Apigee a signed SOAP document that complies with the WS-Security standard.

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

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.png)](https://ssh.cloud.google.com/cloudshell/open?cloudshell_git_repo=https://github.com/ra2085/apigee-usecase-mashup&cloudshell_git_branch=main&cloudshell_workspace=.&cloudshell_tutorial=sample-ws-security/docs/cloudshell-tutorial.md)

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

1. Obtain an inspect a signed envelope

```sh
curl --location --request POST "https://$APIGEE_HOST/v1/samples/ws-security/sign1" --header 'Content-Type: application/xml' --data-raw "<soapenv:Envelope xmlns:ns1='http://ws.example.com/' xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/'><soapenv:Body><ns1:sumResponse><ns1:return>9</ns1:return></ns1:sumResponse></soapenv:Body></soapenv:Envelope>"
```

2. Store the a signed envelope in an environment variable

```sh
SIGNED_ENVELOPE=$(curl --location --request POST "https://$APIGEE_HOST/v1/samples/ws-security/sign1" --header 'Content-Type: application/xml' --data-raw "<soapenv:Envelope xmlns:ns1='http://ws.example.com/' xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/'><soapenv:Body><ns1:sumResponse><ns1:return>9</ns1:return></ns1:sumResponse></soapenv:Body></soapenv:Envelope>")
```

3. Verify the signed envelope

```sh
curl --location --request POST "https://$APIGEE_HOST/v1/samples/ws-security/validate1" --header 'Content-Type: application/xml' --data-raw "$SIGNED_ENVELOPE"
```

Notice the `<valid>true</valid>` element value in the response.

## Cleanup

If you want to clean up the artifacts from this example in your Apigee Organization, first source your `env.sh` script, and then run

```bash
./clean-up-ws-security.sh
```
