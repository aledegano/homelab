# Kubernetes on Raspberry Pi

Manage a k3s Kubernetes cluster on Raspberry Pi.

## Installation

Move to the `ansible_setup` directory and use Ansible to install on the Raspberry Pi(s) everything is needed.
Download the kubeconfig file from the Raspberry Pi and install it locally (in `~/.kube/config`),
replace the `server` value with the FQDN of the Raspberry Pi (instead of `localhost`).

Once `kubectl` is installed on the workstation, verify that works with the kubeconfig file downloaded,
e.g. `kubectl cluster-info`.

### Manual secrets synchronization

I use the excellent [Bitwarden](https://bitwarden.com/) as my personal cloud-based password storage,
once the CLI is installed on the workstation, it can be used to synchronize the secrets to the
Kubernetes cluster on the Raspberry Pi.

Grafana credentials:
```
kubectl create secret generic grafana-admin-credentials --from-literal=username=$(bw get username grafana.raspi.hal) --from-literal=password=$(bw get password grafana.raspi.hal)
```

Minio credentials:
```
kubectl create secret generic minio-secret --from-literal=access_key=$(bw get username minio.raspi.hal) --from-literal=secret_key=$(bw get password minio.raspi.hal)
```

FluxCD private SSH key to access this repo on GitHub (with RW access):
```
bw list items --search github_homelab_deploy_key | jq '.[].notes' -r > /tmp/github_homelab_deploy_key
kubectl create secret generic flux-git-deploy --from-file=identity=/tmp/github_homelab_deploy_key
rm -rf /tmp/github_homelab_deploy_key
```

Deploy FluxCD: `kubectl apply -f flux`.

Flux will take care of deploying all the other application on the cluster, synchronizing directly
with Github.
