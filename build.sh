#!/bin/bash
cp ~/.ssh/id_rsa ssh_key/
sudo docker build . -t ducatuspay
