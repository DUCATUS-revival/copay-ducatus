#!/bin/bash
git pull
npm run apply:copay
grunt prod
#docker-compose restart
