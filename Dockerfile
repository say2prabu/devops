###
# standalone docker image to test generated deployments via terraform plan
# - docker build --pull --rm -f "Dockerfile" -t customertfmodules:latest "."
# - docker run -e 'secrets_file=./jjgsbcust.secrets' customertfmodules
####

FROM alpine:latest

COPY ./ ./src

RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python

RUN apk add --update --no-cache py3-pip

RUN apk add --update --no-cache yq

RUN apk add --update --no-cache jq

RUN apk add --update --no-cache dos2unix

RUN apk add --update --no-cache terraform

CMD cd ./src && dos2unix --quiet ./docker.sh && ./docker.sh $secrets_file $tf_action

#ENTRYPOINT ["/bin/sh", "-c" , "cd ./src && dos2unix --quiet ./docker.sh && ./docker.sh $secrets_file $tf_action"]
