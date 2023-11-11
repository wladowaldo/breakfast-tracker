#!/bin/bash
nginx &
cd /breakfast/client && runuser -u runner -- npm install
cd /breakfast/client && runuser -u runner -- npx vite dev --clearScreen false &
cd /breakfast/api && runuser -u runner -- gunicorn api:app --reload &
sleep 1
echo
echo
echo -e "\033[32m"
echo "###################################"
echo "--> Access on https://127.0.0.1 <--"
echo "###################################"
echo -e "\033[0;39m"
tail -f /dev/null
