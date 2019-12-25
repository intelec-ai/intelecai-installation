@echo off

where docker > nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Please make sure that docker is running before continuing
    pause
)

docker run --rm intelecai/automl-server echo 'AutoML Server image is ready'
docker run --rm intelecai/inference-server echo 'Inference Server image is ready'
docker run --rm mysql:5.7.24 echo 'MySQL Server image is ready'
docker run --rm nginx:1.15-alpine echo 'Nginx Server image is ready'

docker stack deploy -c docker-compose-windows.yml intelecai

echo Starting Intelec AI ...
ping 127.0.0.1 -n 11 > nul
echo Please open http://localhost:7700 in your web browser to visit Intelec AI web page.
