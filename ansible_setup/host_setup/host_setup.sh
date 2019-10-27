#!/bin/bash

sudo apt install -y python3 python3-pip

pip3 install -r py_requirements.txt

ansible-galaxy install -r requirements.yml

curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt` /usr/local/bin
