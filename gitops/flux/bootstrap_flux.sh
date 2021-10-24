#!/bin/bash

if [ "$(bw status | jq '.status' -r)" != "unlocked" ]; then
    echo "Bitwarden must be unlocked"
    exit 1
fi

export GITHUB_TOKEN=$(bw list items --search github_pat_repo_all | jq '.[].notes' -r)

flux bootstrap github \
  --owner=aledegano \
  --repository=homelab \
  --path=applications \
  --personal
