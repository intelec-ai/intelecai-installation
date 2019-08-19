@echo off

where docker > nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Please make sure that docker is running before continuing
    pause
)

docker pull intelecai/automl-server
docker pull intelecai/inference-server
