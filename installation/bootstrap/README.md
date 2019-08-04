### Bootstrap
Run with Ansible only the first time after installing Raspbian.

This playbook performs the following:
- Creates a new default user to which we can login with the specified key
- Enables SSH signing
- Adds the created user to the sudoers
- Enables the containers feature

The following variables must be passed:
`ssh_signer_hostname`: Comma separated list of hostnames used for the ssh signing. If a dns is not setup a fixed IP will do.
`ssh_username`: The username of the default user to log in.
`ssh_public_key`: The path to the SSH public key to authorize for the user.
```
ansible-playbook bootstrap.yml --extra-vars "ssh_signer_hostname=foo,192.168.1.2 ssh_username=foo_user ssh_public_key=~/.ssh/id_rsa.pub"
```
The password associated with the default user is generated randomly and will be copied back on the host.