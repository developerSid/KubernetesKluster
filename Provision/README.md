# Provision

## Tools required
1. [Ansible](https://docs.ansible.com/ansible/latest/index.html)

## Vagrant (VirtualBox)

### Six Node Cluster
Assuming the `vagrant up` command has been issued in the _Kluster/vagrant/virtualbox/sixnode_ directory 
1. execute `ansible-playbook -i inventory/vagrant/virtualbox/sixnode.yml site.yml -k -u vagrant`

### Three Node Cluster
Assuming the `vagrant up` command has been issued in the _Kluster/vagrant/virtualbox/threenode_ directory 
1. execute `ansible-playbook -i inventory/vagrant/virtualbox/threenode.yml site.yml -k -u vagrant`
