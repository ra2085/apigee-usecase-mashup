if [ -z "$PROJECT" ]; then
    echo "No PROJECT variable set"
    exit
fi

if [ -z "$APIGEE_ENV" ]; then
    echo "No APIGEE_ENV variable set"
    exit
fi

if [ -z "$APIGEE_HOST" ]; then
    echo "No APIGEE_HOST variable set"
    exit
fi

TOKEN=$(gcloud auth print-access-token)

echo "Deploying Apigee artifacts..."

echo "Creating API Product"
apigeecli products create --name rest-api-serverless-sample-product --displayname "rest-api-serverless-sample-product"  --envs "$APIGEE_ENV" --scopes "READ" --scopes "WRITE" --scopes "ACTION" --approval auto --quota 50 --interval 1 --unit minute --opgrp ./apiproduct-opgroup.json --org "$PROJECT" --token "$TOKEN"

echo "Creating Developer"
apigeecli developers create --user testuser --email rest-api-serverless_apigeesamples@acme.com --first Test --last User --org "$PROJECT" --token "$TOKEN"

echo "Creating Developer App"
apigeecli apps create --name rest-api-serverless-sample-app --email rest-api-serverless_apigeesamples@acme.com --prods rest-api-serverless-sample-product --callback https://developers.google.com/oauthplayground/ --org "$PROJECT" --token "$TOKEN" --disable-check

CLIENT_ID=$(apigeecli apps get --name rest-api-serverless-sample-app --org "$PROJECT" --token "$TOKEN" --disable-check | jq ."[0].credentials[0].consumerKey" -r)
