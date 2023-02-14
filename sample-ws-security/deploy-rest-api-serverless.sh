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

echo "Generating signing keys..."
mkdir certs
openssl req -subj '/CN=apigee.google.com/O=John Wayne/C=US' -new -newkey rsa:2048 -sha256 -days 365 -nodes -x509 -keyonly -keyout ./certs/server.key -out ./certs/server.crt
PR_KEY=$(cat ./certs/server.key)
echo $PR_KEY
PU_KEY=$(cat ./certs/server.crt)
echo $PU_KEY
PR_KEY=$(printf '%s\n' "$PR_KEY" | tr -d '\n')
PU_KEY=$(printf '%s\n' "$PU_KEY" | tr -d '\n')

echo "Deploying public and private keys for WS-Security signatures..."
echo -e "private_key=$PR_KEY\ncertificate=$PU_KEY" > ws_sec_configuration.properties
apigeecli res create --org "$PROJECT" --env "$APIGEE_ENV" --token "$TOKEN" --name ws_sec_configuration --type properties --respath ws_sec_configuration.properties
rm ws_sec_configuration.properties

echo "Importing and Deploying Apigee sample-ws-security proxy..."
REV=$(apigeecli apis create bundle -f ./apiproxy -n sample-ws-security --org "$PROJECT" --token "$TOKEN" --disable-check | jq ."revision" -r)
apigeecli apis deploy --wait --name sample-ws-security --ovr --rev "$REV" --org "$PROJECT" --env "$APIGEE_ENV" --token "$TOKEN"


echo " "
echo "All the Apigee artifacts are successfully deployed!"
echo " "