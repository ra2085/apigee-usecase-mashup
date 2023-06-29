# ServiceNow SOAP-REST Sample with WS-Security

This sample demonstrates how to transform the ServiceNow Incident table WebService to a REST API. It includes all necessary security configuration to include user credentials and and authorization to access the ServiceNow Incident table WebService.

## Let's get started!

Click the **Start** button to proceed to the next step

## Set your ServiceNow Instance Hostname

Open the Incidents table WSDL file and replace the <walkthrough-editor-select-line filePath="./sample-servicenow-ws-security/incident.wsdl" startLine="872" endLine="872" startCharacterOffset="38" endCharacterOffset="66">SERVICENOW_INSTANCE_HOSTNAME</walkthrough-editor-select-line> placeholder to your ServiceNow Instance hostname.

## Create the Apigee proxy bundle from the Incident WSDL file

Create a proxy bundle using the **wsdl2apigee** tool by executing these commands:

```sh
cd sample-servicenow-ws-security
java -jar wsdl2apigee-1.0.0-jar-with-dependencies.jar -wsdl=./incident.wsdl
unzip ServiceNow_incident.zip
```

## Select GCP Project with Apigee

Select the GCP project where your **Apigee Organization has been provisioned** and click **Next**.

<walkthrough-project-setup></walkthrough-project-setup>

## Set your 


