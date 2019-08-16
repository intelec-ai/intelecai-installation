@echo off

echo Please make sure that docker is running before continuing
pause

docker stack deploy -c docker-compose.yml intelecai
