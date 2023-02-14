# Sample to use WS-Security in Apigee

---
This sample demonstrates how to create or validate in Apigee a signed SOAP document that complies with the WS-Security standard.

Let's get started!

---

## Setup environment

Ensure you have an active GCP account selected in the Cloud shell

```sh
gcloud auth login
```

Navigate to the 'sample-ws-security' directory in the Cloud shell.

```sh
cd sample-ws-security
```

Edit the provided sample `env.sh` file, and set the environment variables there.

Click <walkthrough-editor-open-file filePath="sample-ws-security/env.sh">here</walkthrough-editor-open-file> to open the file in the editor

Then, source the `env.sh` file in the Cloud shell.

```sh
source ./env.sh
```

---

## Deploy Apigee components

Next, let's create and deploy the Apigee resources.

```sh
./deploy-rest-api-serverless.sh
```

### Test the APIs

You can test the API call to make sure the deployment was successful

1. Obtain an inspect a signed envelope

```sh
curl --location --request POST "https://$APIGEE_HOST/v1/samples/vs-security/sign1" --header 'Content-Type: application/xml' --data-raw '<soapenv:Envelope xmlns:ns1='\''http://ws.example.com/'\'' xmlns:soapenv='\''http://schemas.xmlsoap.org/soap/envelope/'\''><soapenv:Body><ns1:sumResponse><ns1:return>9</ns1:return></ns1:sumResponse></soapenv:Body></soapenv:Envelope>' -v
```

2. Store the a signed envelope in an environment variable

```sh
SIGNED_ENVELOPE=$(curl --location --request POST "https://$APIGEE_HOST/v1/samples/vs-security/sign1" --header 'Content-Type: application/xml' --data-raw '<soapenv:Envelope xmlns:ns1='\''http://ws.example.com/'\'' xmlns:soapenv='\''http://schemas.xmlsoap.org/soap/envelope/'\''><soapenv:Body><ns1:sumResponse><ns1:return>9</ns1:return></ns1:sumResponse></soapenv:Body></soapenv:Envelope>')
```

3. Verify the signed envelope

```sh
curl --location --request POST "https://$APIGEE_HOST/v1/samples/vs-security/validate1" --header 'Content-Type: application/xml' --data-raw "$SIGNED_ENVELOPE"
```

Notice the `<valid>true</valid>` element value in the response.

---
## Conclusion

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Congratulations! You've successfully tested WS-Security in Apigee!!

<walkthrough-inline-feedback></walkthrough-inline-feedback>

## Cleanup

If you want to clean up the artifacts from this example in your Apigee Organization, first source your `env.sh` script, and then run

```bash
./clean-up-cloud-run.sh
```
