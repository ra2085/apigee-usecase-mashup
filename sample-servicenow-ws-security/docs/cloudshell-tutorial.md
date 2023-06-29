# ServiceNow SOAP-REST Sample with WS-Security

This sample demonstrates how to transform the ServiceNow Incident table WebService to a REST API. It includes all necessary security configuration to include user credentials and and authorization to access the ServiceNow Incident table WebService.

## Let's get started!

Click the **Start** button to proceed to the next step

## Set your ServiceNow Instance Hostname

Open the Incidents table WSDL file and replace the **SERVICENOW_INSTANCE_HOSTNAME** placeholder to your ServiceNow Instance hostname.

<walkthrough-editor-open-file filePath="./sample-servicenow-ws-security/incident.wsdl">incident.wsdl</walkthrough-editor-open-file>

<walkthrough-editor-select-line filePath="./sample-servicenow-ws-security/incident.wsdl" startLine="873" endLine="873" startCharacterOffset="39" endCharacterOffset="66">replace your ServiceNow Instance hostname</walkthrough-editor-select-line>


## Select GCP Project with Apigee

Select the GCP project where your **Apigee Organization has been provisioned** and click **Next**.

<walkthrough-project-setup></walkthrough-project-setup>

## Set your 


