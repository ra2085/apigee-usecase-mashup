# Sample to use SAML Assertions in Apigee

---
This sample demonstrates how to create and validate in Apigee signed SAML assertions.

Let's get started!

---

## Setup environment

Ensure you have an active GCP account selected in the Cloud shell

```sh
gcloud auth login
```

Navigate to the 'sample-saml-auth' directory in the Cloud shell.

```sh
cd sample-saml-auth
```

Edit the provided sample `env.sh` file, and set the environment variables there.

Click <walkthrough-editor-open-file filePath="sample-saml-auth/env.sh">here</walkthrough-editor-open-file> to open the file in the editor

Then, source the `env.sh` file in the Cloud shell.

```sh
source ./env.sh
```

---

## Deploy Apigee components

Next, let's create and deploy the Apigee resources.

```sh
./deploy-saml-auth.sh
```

### Test the APIs

You can test the API call to make sure the deployment was successful

1. Obtain an inspect a signed SAML Assertion

```sh
curl --location --request POST "https://$APIGEE_HOST/v1/samples/saml-auth/generate-saml" --header 'Content-Type: application/xml' --data-raw "<soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:examples:helloservice\"><soapenv:Header/><soapenv:Body><urn:sayHello soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"><firstName xsi:type=\"xsd:string\">John Doe</firstName></urn:sayHello></soapenv:Body></soapenv:Envelope>"
```

2. Store the a signed envelope in an environment variable

```sh
SIGNED_ASSERTION=$(curl --location --request POST "https://$APIGEE_HOST/v1/samples/saml-auth/generate-saml" --header 'Content-Type: application/xml' --data-raw "<soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:examples:helloservice\"><soapenv:Header/><soapenv:Body><urn:sayHello soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"><firstName xsi:type=\"xsd:string\">John Doe</firstName></urn:sayHello></soapenv:Body></soapenv:Envelope>")
```

3. Store the a signed SAML assertion in an environment variable

```sh
curl --location --request POST "https://$APIGEE_HOST/v1/samples/saml-auth/validate-saml" --header 'Content-Type: application/xml' --data-raw "$SIGNED_ASSERTION"
```

Notice the `200 OK response code` in the response.

---
## Conclusion

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Congratulations! You've successfully tested SAML generation and verification in Apigee!!

<walkthrough-inline-feedback></walkthrough-inline-feedback>

## Cleanup

If you want to clean up the artifacts from this example in your Apigee Organization, first source your `env.sh` script, and then run

```bash
./clean-up-saml-auth.sh
```
