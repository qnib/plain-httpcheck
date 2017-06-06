#!/bin/bash

if [[ $(curl -s "127.0.0.1:${LISTEN_PORT:-8080}/health" |jq '.Status==200') == "true" ]];then
   echo ">> Status OK: 200" 
   exit 0
else 
   curl -s "127.0.0.1:${LISTEN_PORT:-8080}/health"
   exit 1
fi 
