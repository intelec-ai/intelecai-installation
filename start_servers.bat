@echo off

echo Please make sure that docker is running before continuing
pause

docker swarm init > nul 2>&1

REM Download images, if they have not been downloaded so far
docker run --rm intelecai/automl-server echo 'AutoML Server image is ready'
docker run --rm intelecai/inference-server echo 'Inference Server image is ready'
docker run --rm mysql:5.7.24 echo 'MySQL Server image is ready'
docker run --rm nginx:1.15-alpine echo 'Nginx Server image is ready'

REM Copy config files to docker volumes
docker run -v intelecai_config-db:/config/db -v intelecai_config-nginx:/config/nginx --name dummy-helper1 busybox true
docker cp config\db\. dummy-helper1:/config/db
docker cp config\nginx\. dummy-helper1:/config/nginx
docker rm dummy-helper1 > nul 2>&1

docker stack deploy -c docker-compose-windows.yml intelecai

echo Starting Intelec AI ...
ping 127.0.0.1 -n 11 > nul
echo Please open http://localhost:7700 in your web browser to visit Intelec AI web page.
