#!/bin/bash
#Send a Notification to all Push Bullet devices

#PB_API_KEY=
curl -s -u "$PB_API_KEY": https://api.pushbullet.com/v2/pushes -d type=note -d title="$1" -d body="$2" > /dev/null 2>&1
