@echo off

REM ask user accept license agreement
echo.
echo Welcome! This script will help you set up Intelec AI in your computer.
echo First, you need to read and accept the license agreement.
pause
echo.

type LICENSE
echo.
:ask_licence_accept
set /P accept="Do you accept the above license agreement (yes/no)? " 
if '%accept%'=='yes' goto license_accepted
if '%accept%'=='Yes' goto license_accepted
if '%accept%'=='no' goto license_declined
if '%accept%'=='No' goto license_declined
goto ask_licence_accept
:license_declined
exit /B
:license_accepted

echo.
set /P sftp_pass="Create FTP password: "
set /P mysql_root_pass="Create database root password: "
set /P db_rpt_user_pass="Create database report user password: "
set /P admin_pass="Create admin password for web application: "

echo.
echo Please make sure that docker is running before continuing
pause

REM generate random database user password for the app
SET db_app_user_pass=%random%%random%%random%%random%%random%%random%
SET db_app_user_pass=%db_app_user_pass:0=a%
SET db_app_user_pass=%db_app_user_pass:1=b%
SET db_app_user_pass=%db_app_user_pass:2=c%
SET db_app_user_pass=%db_app_user_pass:3=d%
SET db_app_user_pass=%db_app_user_pass:4=e%
SET db_app_user_pass=%db_app_user_pass:5=f%

REM generate random session key
SET session_key=%random%%random%%random%%random%%random%%random%%random%%random%%random%
SET session_key=%session_key:0=a%
SET session_key=%session_key:1=b%
SET session_key=%session_key:2=c%
SET session_key=%session_key:3=d%
SET session_key=%session_key:4=e%
SET session_key=%session_key:5=f%

if not exist "config" mkdir config
if not exist "config\db" mkdir config\db
if not exist "config\nginx" mkdir config\nginx

echo ftpuser:%sftp_pass%:1000:100:upload > config\sftp_users.conf
echo MYSQL_ROOT_PASSWORD=%mysql_root_pass% > config\db\mysql_root_password.env

REM Read database initialization template, put app and report user passwords in and write the result into a config file
SETLOCAL EnableDelayedExpansion
for /f "Tokens=* Delims=" %%x in (template\db_init.sql) do set db_init_template=!db_init_template!%%x
set tmp=%db_init_template:app_user_password=!db_app_user_pass!%
echo %tmp:report_user_password=!db_rpt_user_pass!% > config\db\db_init.sql

REM build automl.en file
echo DB_HOST=db > config/automl.env
echo DB_NAME=intelec_ai >> config/automl.env
echo DB_USER=app_user >> config/automl.env
echo DB_PASS=%db_app_user_pass% >> config/automl.env
echo SESSION_NAME=in_ai_session >> config/automl.env
echo SESSION_VALUE=%session_key% >> config/automl.env
echo ADMIN_USERNAME=admin >> config/automl.env
echo ADMIN_PASSWORD=%admin_pass% >> config/automl.env

robocopy "template\nginx" "config\nginx" > nul 2>&1

echo Starting to download required software (docker images)
docker swarm init > nul 2>&1
docker pull intelecai/automl-server
docker pull intelecai/inference-server
docker pull mysql:5.7.24
docker pull atmoz/sftp:debian-stretch
docker pull nginx:1.15-alpine

echo.
echo DONE!
echo.

echo FTP user details were saved in config\sftp_users.conf
echo Database root password was saved in config\db\mysql_root_password.env
echo Another database user details can be found in config\db\db_init.sql
echo Admin password for web application was saved in config\automl.env

echo.
pause