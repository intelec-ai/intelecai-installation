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
docker volume rm intelecai_root

config=`cat config/config.txt`
if [ "$config" = "gpu_support=true" ]; then
    docker image rm intelecai/automl-server:latest-gpu
else
    docker image rm intelecai/automl-server
fi

docker image rm intelecai/inference-server

echo 
echo "Intelec AI was uninstalled successfully."
echo 
