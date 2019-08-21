#!/bin/bash

rm -rf config

docker volume rm intelecai_db-data
docker volume rm intelecai_deployed-models
docker volume rm intelecai_sftp-ssh
docker volume rm intelecai_training
docker volume rm intelecai_user-home

docker image rm intelecai/automl-server
docker image rm intelecai/inference-server
