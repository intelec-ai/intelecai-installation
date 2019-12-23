#!/bin/bash

hash docker 2>/dev/null || {
    echo "Please make sure that docker is running before continuing "
    read -n 1 -s -r -p "Press any key to continue ..."
    echo
}

if [ "$1" = "--gpu" ]; then
    docker stack deploy -c docker-compose-gpu.yml intelecai
else
    docker stack deploy -c docker-compose.yml intelecai
fi
