#!/bin/bash

hash docker 2>/dev/null || {
    echo "Please make sure that docker is running before continuing "
    read -n 1 -s -r -p "Press any key to continue ..."
    echo 
}

docker pull intelecai/automl-server
docker pull intelecai/inference-server
