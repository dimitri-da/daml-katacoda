#!/bin/bash

init()
{
    cd /tmp
    ~/.daml/bin/daml new create-daml-app create-daml-app
    mkdir -p /root/create-daml-app
    mv create-daml-app/* /root/create-daml-app/
    cd /root/create-daml-app/ui
    echo "DANGEROUSLY_DISABLE_HOST_CHECK=true" >> .env
    sed -i 's+ws://localhost:7575/+wss://2886795313-7575-maple01.environments.katacoda.com/+g' src/config.ts
}

echo Initialising...
init
echo Done!
