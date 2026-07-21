@echo off

newman run "https://api.getpostman.com/collections/COLLECTION_UID" ^
-e "https://api.getpostman.com/environments/ENVIRONMENT_UID" ^
--postman-api-key "%POSTMAN_API_KEY%" ^
--env-var "key=%TRELLO_KEY%" ^
--env-var "token=%TRELLO_TOKEN%"
