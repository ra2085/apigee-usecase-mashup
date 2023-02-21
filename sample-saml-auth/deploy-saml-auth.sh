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

echo "Installing apigeecli"
curl -s https://raw.githubusercontent.com/apigee/apigeecli/master/downloadLatest.sh | bash
export PATH=$PATH:$HOME/.apigeecli/bin

TOKEN=$(gcloud auth print-access-token)

echo "Creating key pair..."
openssl req -new -subj '/CN=cymbal.com/O=Demo/C=US' -newkey rsa:2048 -sha256 -days 365 -nodes -x509 -keyout sa.key -out sa.crt

echo "Creating key stores..."
apigeecli keystores create --name saml-key --org "$PROJECT" --env "$APIGEE_ENV" --token "$TOKEN"
apigeecli keystores create --name saml-crt --org "$PROJECT" --env "$APIGEE_ENV" --token "$TOKEN"
apigeecli keyaliases create --key saml-key --alias saml-key --format pem --certFilePath ./sa.crt --keyFilePath ./sa.key --org "$PROJECT" --env "$APIGEE_ENV" --token "$TOKEN"
apigeecli keyaliases create --key saml-crt --alias saml-crt --format pem --certFilePath ./sa.crt --org "$PROJECT" --env "$APIGEE_ENV" --token "$TOKEN"

echo "Importing and Deploying Apigee sample-saml-auth proxy..."
REV=$(apigeecli apis create bundle -f ./apiproxy -n sample-saml-auth --org "$PROJECT" --token "$TOKEN" --disable-check | jq ."revision" -r)
apigeecli apis deploy --wait --name sample-saml-auth --ovr --rev "$REV" --org "$PROJECT" --env "$APIGEE_ENV" --token "$TOKEN"


echo " "
echo "All the Apigee artifacts are successfully deployed!"
echo " "