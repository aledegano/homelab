# Install k3s on a virgin Raspberry Pi

## Setting up the image on the SD card
- Use balena-etcher to flash the latest raspbian on the SD card
- Once the flash is complete create an empty `ssh` file in the /boot partition
- Set a static IP by writing in `/etc/dhcpcd.conf` of the SD card (rootfs partition):
```
interface eth0
static ip_address=192.168.1.10/24
static routers=192.168.1.1
static domain_name_servers=192.168.1.1 192.168.1.7
```

## Assumptions
- Raspberry Pi
- Deployed server-raspbian
- Default user/pass available

## How-to
- Install the required dependencies on the workstation: `./host_setup/host_setup.sh`
- Run the playbook to setup the user: `ansible-playbook -i raspi_pre_user.ini user.yml` with the default user
- Run the playbook to complete the k3s installation: `ansible-playbook -i inventory.yml k3s_deploy.yml` which will remove the default Raspbian user

### Requirements
- python2.7
- pip
- virtualenv
- setuptools
