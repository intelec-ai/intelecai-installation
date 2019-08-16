#!/bin/bash

# ask user accept license agreement
echo
echo "Welcome! This script will help you set up Intelec AI in your computer."
echo "First, you need to read and accept the license agreement."
read -n 1 -s -r -p "Please press any key to continue ..."
echo -e "\n\n"

cat LICENSE
echo
echo "You need to accept the above license agreement to continue:"
echo "- please press ENTER to accept the license agreement"
echo "- please press ESC key to exit, if you don't want to accept the agreement"

# Loop until either Enter or Esc key was pressed
while true; do 
    read -s -n1  key
    if [ "$key" = $'\e' ]; then
        echo "Set up was cancelled."
        exit
    elif [ "$key" = '' ] ;then
        break
    fi
done

echo
read -s -p "Create FTP password: " sftp_pass
echo

read -s -p "Create database root password: " mysql_root_pass
echo

read -s -p "Create database report user password: " db_rpt_user_pass
echo

read -s -p "Create admin password for web application: " admin_pass
echo

echo
echo "Please make sure that docker is running before continuing "
read -n 1 -s -r -p "Press any key to continue ..."
echo 
echo 

mkdir -p config/db
mkdir -p config/nginx

echo ftpuser:$sftp_pass:1000:100:upload > config/sftp_users.conf
echo MYSQL_ROOT_PASSWORD=$mysql_root_pass > config/db/mysql_root_password.env

# generate random database user password for the app
db_app_user_pass=`openssl rand -base64 12`
# create database initialization script using the template
db_init_template=`cat template/db_init.sql`
tmp="${db_init_template/app_user_password/$db_app_user_pass}"
echo "${tmp/report_user_password/$db_rpt_user_pass}" > config/db/db_init.sql

# create random session key
session_key=`openssl rand -base64 30`
# build automl.env file
echo "DB_HOST=db" > config/automl.env
echo "DB_NAME=intelec_ai" >> config/automl.env
echo "DB_USER=app_user" >> config/automl.env
echo "DB_PASS=$db_app_user_pass" >> config/automl.env
echo "SESSION_NAME=in_ai_session" >> config/automl.env
echo "SESSION_VALUE=$session_key" >> config/automl.env
echo "ADMIN_USERNAME=admin" >> config/automl.env
echo "ADMIN_PASSWORD=$admin_pass" >> config/automl.env

cp template/nginx/* config/nginx/

echo "Starting to download required software (docker images)"
docker swarm init > /dev/null 2>&1
docker pull intelecai/automl-server
docker pull intelecai/inference-server
docker pull mysql:5.7.24
docker pull atmoz/sftp:debian-stretch
docker pull nginx:1.15-alpine

echo
echo DONE!
echo

echo FTP user details were saved in config/sftp_users.conf
echo Database root password was saved in config/db/mysql_root_password.env
echo Another database user details can be found in config/db/db_init.sql
echo Admin password for web application was saved in config/automl.env
echo