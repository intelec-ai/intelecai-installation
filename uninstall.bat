@echo off

where docker > nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Please make sure that docker is running before continuing
    pause
)

REM delete config folder
DEL /F/Q/S config > NUL
RMDIR /Q/S config

docker volume rm intelecai_db-data
docker volume rm intelecai_deployed-models
docker volume rm intelecai_sftp-ssh
docker volume rm intelecai_training
docker volume rm intelecai_user-home
docker volume rm intelecai_config-db
docker volume rm intelecai_config-nginx
docker volume rm intelecai_config-sftp 

docker image rm intelecai/automl-server
docker image rm intelecai/inference-server

echo.
echo Intelec AI was uninstalled successfully.

echo.
echo Press any key to exit . . .
pause > nul
