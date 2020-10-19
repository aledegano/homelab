# Install k3s on a virgin Raspberry Pi
## Assumptions
- Raspberry Pi
- Deployed server-raspbian
- Default user/pass available

## How-to
- Install the required dependencies on the workstation: `./host_setup/host_setup.sh`
- Run the playbook to setup the user: `ansible-playbook -i raspi_pre_user.ini user.yml` with the default user
- Run the playbook to complete the k3s installation: `ansible-playbook -i inventory.ini k3s_deploy.yml` which will remove the default Raspbian user

### Requirements
- python2.7
- pip
- virtualenv
- setuptools
