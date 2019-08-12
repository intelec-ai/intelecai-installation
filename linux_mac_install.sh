#!/bin/bash

config_folder="test_config"

mkdir -p $config_folder/db
mkdir -p $config_folder/nginx

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

echo DONE!
echo FTP user details were saved in $config_folder/sftp_users.conf
echo Database root password was saved in $config_folder/db/mysql_root_password.env
echo Another database user details can be found in $config_folder/db/db_init.sql
echo Admin password for web application was saved in $config_folder/automl.env
