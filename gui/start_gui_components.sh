#!/bin/bash
cd /breakfast/gui/client && npm install
cd /breakfast/gui/client && ./start_client.sh &
cd /breakfast/gui/api && python3 api.py &
tail -f /dev/null

