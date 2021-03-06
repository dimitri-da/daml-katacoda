#!/bin/bash

echo initializing...

# workaround for assets in the `assets` directory, because google-chrome complains when the file
# size is bigger than 50kb
wget https://katacoda.com/daml/courses/upgrading/upgrade-ui/assets/create-daml-app.tar.gz

tar xzf create-daml-app.tar.gz
cd create-daml-app
sed -i 's+ws://localhost:7575/+wss://[[HOST_SUBDOMAIN]]-7575-[[KATACODA_HOST]].environments.katacoda.com/+g' ui/src/config.ts
mkdir .daml
cd /tmp
sdk_version=$(~/.daml/bin/daml version | awk '/(default SDK version for new projects)/ {print $1}')
echo "DAML SDK version is" $sdk_version
sed -i "/sdk-version: /c\sdk-version: $sdk_version" /root/create-daml-app/daml.yaml
cd /root
rm create-daml-app.tar.gz

echo done
