#!/bin/bash -ex

sudo apt install -y python3 python3-pip

pip3 install -r py_requirements.txt

ansible-galaxy install -r requirements.yml

pushd /usr/local/bin
sudo curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
sudo chmod 0755 /usr/local/bin/kubectl
popd
