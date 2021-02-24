# Ansible

This folder contains the Ansible that configures all of my static infrastructure and cloud images built with Packer.

## Running

Configure the entire static infrastructure.

```shell
ansible-playbook -i inventory.yml site.yml
```
