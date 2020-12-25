#!/bin/bash

hash docker 2>/dev/null || {
    echo "Please make sure that docker is running before continuing "
    read -n 1 -s -r -p "Press any key to continue ..."
    echo
}

docker swarm init 2>/dev/null

docker run --rm intelecai/inference-server echo 'Inference Server image is ready'
docker run --rm mysql:5.7.24 echo 'MySQL Server image is ready'
docker run --rm nginx:1.15-alpine echo 'Nginx Server image is ready'
docker run --rm intelecai/automl-server echo 'AutoML Server image is ready'

docker stack deploy -c docker-compose.yml intelecai

echo "Starting Intelec AI ..."
sleep 20
echo "Please open http://localhost:7700 in your web browser to visit Intelec AI web page."
