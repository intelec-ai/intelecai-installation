echo "Please make sure that docker is running before continuing "
read -n 1 -s -r -p "Press any key to continue ..."
echo

docker stack deploy -c docker-compose.yml intelecai
