# ServiceNow SOAP-REST Sample with WS-Security

This sample demonstrates how to transform the ServiceNow Incident table WebService to a REST API. It includes all necessary security configuration to include user credentials and and authorization to access the ServiceNow Incident table WebService.

## Let's get started!

Click the **Start** button to proceed to the next step.

## Set your ServiceNow Instance Hostname

Open the Incidents table WSDL file and replace the **SERVICENOW_INSTANCE_HOSTNAME** placeholder to your ServiceNow Instance hostname.

Click the following link to open the WSDL file in a new tab:

<walkthrough-editor-select-line filePath="./sample-servicenow-ws-security/incident.wsdl" startLine="872" endLine="872" startCharacterOffset="38" endCharacterOffset="66">SERVICENOW_INSTANCE_HOSTNAME</walkthrough-editor-select-line>

Proceed to the next step.

## Create the Apigee proxy bundle from the Incident WSDL file

Create a proxy bundle using the **wsdl2apigee** tool by executing these commands:

```sh
cd sample-servicenow-ws-security
java -jar wsdl2apigee-1.0.0-jar-with-dependencies.jar -wsdl=./incident.wsdl
unzip ServiceNow_incident.zip
```

Proceed to the next step.

## Modify the Incidents proxy bundle

### Create ServiceNow security Flow Callout policy

Create a Flow Callout that will reference the ServiceNow Security Shared Flow by executing these commands:

```sh
mv ./templates/FC-ServiceNow-Sec.xml ./apiproxy/policies/FC-ServiceNow-Sec.xml
```

### Attach Flow Callout to Target Service

Attach the Flow Callout to the PreFlow of the default Target Service configuration file. Copy the following lines:

```
<Step>
    <Name>FC-ServiceNow-Sec</Name>
</Step>
```

Paste the contents of your clipboard in the default TargetService configuration file between lines 9 and 10. Follow this <walkthrough-editor-select-line filePath="./sample-servicenow-ws-security/proxybundle/targets/default.xml" startLine="8" endLine="8" startCharacterOffset="12" endCharacterOffset="12">link</walkthrough-editor-select-line> to open the file on these lines.

### Replace the query parameters extract policy with a template

Execute the the folowing command to replace the policy file:

```sh
mv ./templates/getRecords-extract-query-param.xml ./proxybundle/policies/getRecords-extract-query-param.xml
```

### Add a SOAP envelope body to the getRecords operation

Copy the follwing lines:

```
<soapenv:Body>
    <inc:getRecords>
        <active>{isActive}</active>
    </inc:getRecords>
</soapenv:Body>
```

Replace the contents of line 17 with the contents your clipboard in the getRecords-build-soap policy file. Follow this <walkthrough-editor-select-line filePath="./sample-servicenow-ws-security/proxybundle/targets/default.xml" startLine="16" endLine="16" startCharacterOffset="7" endCharacterOffset="26">link</walkthrough-editor-select-line> to open the file on line 17.

Proceed to the next step.

## Set your properties file with ServhceNow credentials

### Review Sample properties fule

Review the contents of the sample comfiguration file by clicking on this <walkthrough-editor-open-file filePath="./sample-servicenow-ws-security/just_a_sample.properties">link</walkthrough-editor-open-file>. In it you'll find the following sample properties:

- **username** is the ServiceNow Instance username.
- **password** is the ServiceNow Instance password.
- **key** is the private key in PEM format to generate a WS-Security signature. Note that for every new line the line must end with a `\n\`.
- **cert** is the certificate in PEM formate to verify a WS-Security siggnature. Note that for every new line the line must end with a `\n\`.

### Edit servicenow properties file

Provide **your own** credentials by editing the **servicenow.properties** file available in this <walkthrough-editor-open-file filePath="./sample-servicenow-ws-security/servicenow.properties">link</walkthrough-editor-open-file>.

Proceed to the next step.

## Select GCP Project with Apigee

Select the GCP project where your **Apigee Organization has been provisioned** and click **Next**.

<walkthrough-project-setup></walkthrough-project-setup>

Proceed to the next step.

## Set environment variables

Set your Apigee environment name as an env variable. Replace the placeholder on each of the following scripts and execute them:

```sh
export PROJECT_ID=<walkthrough-project-id/> # e.g. "my-project-id"
```
```sh
export APIGEE_ENV="REPLACE_WITH_APIGEE_ENV_NAME" # e.g. "my-project-id"
```
```sh
export APIGEE_HOST="APIGEE_DOMAIN_NAME" # e.g. "34-149-156-6.nip.io"
```

Proceed to the next step.

## Deploy the solution

Deploy the properties file, sharedflow, and proxy bundle to your Apigee environemnt by executing the following command:

```sh
./deploy-servicenow-ws-security.sh
```
Proceed to the next step.

## Test the solution

Test the solution by executing the following cURL command:

```sh
curl -X GET "https://$APIGEE_HOST//ervicenow_incident/records?active=true"
```
Proceed to the next step.

## Cleanup

If you want to delete the artifacts from this example from your Apigee Organization, then execute the following command

```bash
./clean-up-servicenow-ws-security.sh
```

## Conclusion

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Congratulations! You've successfully completed this tutorial.

<walkthrough-inline-feedback></walkthrough-inline-feedback>