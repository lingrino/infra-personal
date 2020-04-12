# Ansible

This folder contains the Ansible that configures all of my static infrastructure and cloud images built with Packer.

## Running

Configure the entire static infrastructure. Does not build packer images (see [../packer/README.md][] for building those).

```shell
ansible-playbook -i inventory.yml site.yml
```
