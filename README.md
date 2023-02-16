# Apigee Usecases Mashup

---

## <a name="intro"></a>Intro

This repository contains a collection of sample API proxies that you can deploy and run on Apigee X or [hybrid](https://cloud.google.com/apigee/docs/hybrid/v1.8/what-is-hybrid).

The samples provide a jump-start for developers who wish to design and create Apigee API proxies.

### <a name="who"></a>Audience

You are an [Apigee](https://cloud.google.com/apigee) API proxy developer, or you would like to learn about developing APIs that run on Apigee X & hybrid. At a minimum, we assume you're familiar with Apigee and how to create simple API proxies. To learn more, we recommend this [getting started tutorial](https://cloud.google.com/apigee/docs/api-platform/get-started/get-started).

## <a name="before"></a>Before you begin

1. See the full list of [Prerequisites](https://cloud.google.com/apigee/docs/api-platform/get-started/prerequisites) for installing Apigee.

2. You'll need access to a Google Cloud Platform account and project. [Sign up for a free GCP trial account.](https://console.cloud.google.com/freetrial)

3. If you don't have one, you'll need to provision an Apigee instance. [Create a free Apigee eval instance.](https://apigee.google.com/setup/eval)

4. Clone this project from GitHub to your system.

## <a name="using"></a>Using the sample proxies

Most developers begin by identifying an interesting sample based on a specific use case or need. You'll find all the samples in the root folder.

### <a name="samples"></a>Samples
- [authorize-idp-access-tokens](authorize-idp-access-tokens) - 
  Authorize JWT access tokens issued by an Identity Provider  
- [sample-basic-authn](sample-basic-authn) -
  Authentecate API calls by verifyng credentials from a Basic Authentication header
- [sample-ws-security](sample-ws-security) -
  Verify SOAP envelopes using WS Security signature verification
- [sample-rest-api-serverless](sample-rest-api-serverless) -
  Deploy a mock service on a Serverless function and identify a consumer using API Keys

### <a name="modifying"></a>Modifying a sample proxy

Feel free to modify and build upon the sample proxies. You can make changes in the Apigee [management UI](https://cloud.google.com/apigee/docs/api-platform/develop/ui-edit-proxy) or by using our Cloud Code [extension for local development](https://cloud.google.com/apigee/docs/api-platform/local-development/setup) in Visual Studio Code. Whichever approach is comfortable for you.

Simply redeploy the proxies for changes to take effect.

## <a name="docs"></a>Apigee documentation

The Apigee docs are located [here](https://cloud.google.com/apigee/docs).

## License

All solutions within this repository are provided under the
[Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0) license.
Please see the [LICENSE](./LICENSE.txt) file for more detailed terms and conditions.

## Not Google Product Clause

This is not an officially supported Google product, nor is it part of an
official Google product.

## Support

If you need support or assistance, feel free to reach out to your dedicared Apigee Engineer.