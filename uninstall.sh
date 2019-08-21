#!/bin/bash

hash docker 2>/dev/null || {
    echo "Please make sure that docker is running before continuing "
    read -n 1 -s -r -p "Press any key to continue ..."
    echo 
}

rm -rf config

docker volume rm intelecai_db-data
docker volume rm intelecai_deployed-models
docker volume rm intelecai_sftp-ssh
docker volume rm intelecai_training
docker volume rm intelecai_user-home

docker image rm intelecai/automl-server
docker image rm intelecai/inference-server

echo "Intelec AI was uninstalled successfully."
