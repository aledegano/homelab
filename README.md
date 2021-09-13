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
kubectl --namespace metrics create secret generic grafana-admin-credentials --from-literal=username=$(bw get username grafana.raspi.hal) --from-literal=password=$(bw get password grafana.raspi.hal)
```

Deploy FluxCD: execute `./flux/bootstrap_flux.sh`.
FluxCD will take care of applying all the manifests defined in `kubernetes` directly from this
GitHub repository.

Discord webhook for notifications:
```
kubectl --namespace flux-system create secret generic discord-url --from-literal=address=$(bw get password discord-webhook)
```
