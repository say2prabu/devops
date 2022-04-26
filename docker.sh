#!/bin/sh
function get_time_stamp {
  echo "$(date +"%a %b %d %Y %H:%M:%S")"
}

echo "[$(get_time_stamp) - $0] Started"

while IFS="=" read -r a b
do
    eval a=$a
    eval b=$b
    export $a=$b
done < $1

export ENV=$(yq eval --output-format=json dev.yaml | jq -r '.Env')
export APP=$(yq eval --output-format=json dev.yaml | jq -r '.ApplicationName')
export FILE_NAME="$ENV-$APP.json"
#echo "ENV=$ENV" >> $GITHUB_ENV
#echo "APP=$APP" >> $GITHUB_ENV


echo '{
"resource_group_name": "'${TF_STATE_SA_RG_NAME}'",
"storage_account_name": "'${TF_STATE_SA_NAME}'",
"container_name": "'${TF_STATE_SA_CONTAINER_NAME}'",
"subscription_id": "'${ARM_SUBSCRIPTION_ID}'",
"access_key": "'${ARM_ACCESS_KEY}'",
"key":  "'$FILE_NAME'",
"tenant_id" : "'${ARM_TENANT_ID}'"
}' > ./tf.backend.config.json

echo '{
"subscription_id": "'${ARM_SUBSCRIPTION_ID}'",
"tenant_id" : "'${ARM_TENANT_ID}'",
"client_id": "'${ARM_CLIENT_ID}'",
"client_secret": "'${ARM_CLIENT_SECRET}'"
}' > ./tf.creds.config.json

mkdir $ENV

cp ./tf.backend.config.json $ENV/tf.backend.config.json
cp ./tf.creds.config.json $ENV/tf.creds.config.json

# Runs a set of commands using the runners shell
echo "[$(get_time_stamp) - $0] Preparing python environment"

rm -f ./main.tf $ENV.yaml.json
#ls -ltr
pip install --quiet --no-color --requirement ./py_scripts/requirements.txt

echo "[$(get_time_stamp) - $0] Generating module"
python ./py_scripts/create_module.py dev.yaml

cp ./py_scripts/provider.tf $ENV/provider.tf
cp ./main.tf $ENV/main.tf
# ls -ltr
# ls -ltr $ENV
cat $ENV/main.tf

echo "[$(get_time_stamp) - $0] Terraform phase"

terraform version

terraform -chdir="$ENV" init --backend-config tf.backend.config.json

terraform -chdir="$ENV" validate

case $2 in
  'apply')
    terraform -chdir="$ENV" apply -auto-approve -var-file="tf.creds.config.json"
    ;;

  'destroy')
    terraform -chdir="$ENV" destroy -auto-approve -var-file="tf.creds.config.json"
    ;;

  *)
    terraform -chdir="$ENV" plan -var-file="tf.creds.config.json"
    ;;
esac

echo "[$(get_time_stamp) - $0] Finished"
