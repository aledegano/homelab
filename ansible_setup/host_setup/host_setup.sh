#!/bin/bash

sudo apt install -y python3 python3-pip

pip3 install -r py_requirements.txt

ansible-galaxy install -r requirements.yml