#!/bin/bash

# ask user accept license agreement
echo
echo "Welcome! This script will help you set up Intelec AI in your computer."
echo "First, you need to read and accept the license agreement."
read -n 1 -s -r -p "Please press any key to continue "
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
        echo "[ESC] was pressed. Set up was cancelled."
        exit
    elif [ "$key" = '' ] ;then
        break
    fi
done

config_folder="config"

mkdir -p $config_folder/db
mkdir -p $config_folder/nginx

echo
echo -n "Create FTP password: "
read -s sftp_pass
echo
echo ftpuser:$sftp_pass:1000:100:upload > $config_folder/sftp_users.conf

echo -n "Create database root password: "
read -s mysql_root_pass
echo
echo MYSQL_ROOT_PASSWORD=$mysql_root_pass > $config_folder/db/mysql_root_password.env

# generate random database user password for the app
db_app_user_pass=`openssl rand -base64 12`
echo -n "Create database report user password: "
read -s db_rpt_user_pass
echo
db_init_template=`cat template/db_init.sql`
tmp="${db_init_template/app_user_password/$db_app_user_pass}"
echo "${tmp/report_user_password/$db_rpt_user_pass}" > $config_folder/db/db_init.sql

echo -n "Create admin password for web application: "
read -s admin_pass
echo
automl_template=`cat template/automl.env`
# create random session key
session_key=`openssl rand -base64 30`
printf "$automl_template" "$db_app_user_pass" "$session_key" "$admin_pass" > $config_folder/automl.env

cp template/nginx/* $config_folder/nginx/

echo "Starting to download required software (docker images)"
docker swarm init > /dev/null 2>&1
docker pull intelecai/automl-server
docker pull intelecai/inference-server
docker pull mysql:5.7.24
docker pull atmoz/sftp:debian-stretch
docker pull nginx:1.15-alpine

echo DONE!
echo FTP user details were saved in $config_folder/sftp_users.conf
echo Database root password was saved in $config_folder/db/mysql_root_password.env
echo Another database user details can be found in $config_folder/db/db_init.sql
echo Admin password for web application was saved in $config_folder/automl.env
