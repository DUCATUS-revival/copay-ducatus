#!/bin/bash
cp ~/.ssh/id_rsa ssh_key/
sudo docker build . --force-rm --no-cache -t ducatuspay
