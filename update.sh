#!/bin/bash

hash docker 2>/dev/null || {
    echo "Please make sure that docker is running before continuing "
    read -n 1 -s -r -p "Press any key to continue ..."
    echo 
}

config=`cat config/config.txt`
if [ "$config" = "gpu_support=true" ]; then
    docker pull intelecai/automl-server:latest-gpu
else
    docker pull intelecai/automl-server
fi

docker pull intelecai/inference-server

echo 
echo "Intelec AI was updated successfully."
echo 
