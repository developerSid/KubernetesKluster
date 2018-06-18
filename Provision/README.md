# Provision

## Tools required
1. [Ansible](https://docs.ansible.com/ansible/latest/index.html)

## Do Provision
Assuming the `vagrant up` command has been issued in the _Kluster_ directory (or a cluster of machines
has been built is some other way with the inventory updated appropriately)

1. Change directory to the _Provsion_ directory
1. execute `ansible-playbook -i inventory/vagrant.ini site.yml -k -K -u vagrant --tags=etcd` to install etcd
   1. prompts triggered by the `ansible-playbook` command
      1. ssh password: `vagrant`
      1. sudo password: `vagrant`
1. check that the etcd cluster gets up and running
   1. Change directory back to teh _Kluster_ directory
   1. `vagrant ssh master01`
   1. `/opt/etcd/etcd-${etcdVer}-linux-amd64/etcdctl/etcdctl member list`
      1 ${etcdVer} can be found for the vagrant based cluster in the _Provision/group_vars/vagrant_
      1. Examples
         1. List the members of the cluster
            ```bash
            sudo -u etcd ETCDCTL_API=3 /opt/etcd/etcd-v3.3.7-linux-amd64/etcdctl member list \
              --endpoints=https://127.0.0.1:2379 \
              --cacert=/opt/etcd/ssl/ca.pem \
              --cert=/opt/etcd/ssl/kube-master01.vagrant.example.pem \
              --key=/opt/etcd/ssl/kube-master01.vagrant.example-key.pem
            ```
         1. List the health of the cluster
            ```bash
            sudo -u etcd ETCDCTL_API=3 /opt/etcd/etcd-v3.3.7-linux-amd64/etcdctl endpoint --cluster health \
              --endpoints=https://127.0.0.1:2379 \
              --cacert=/opt/etcd/ssl/ca.pem \
              --cert=/opt/etcd/ssl/kube-master01.vagrant.example.pem \
              --key=/opt/etcd/ssl/kube-master01.vagrant.example-key.pem
            ```
         1. List endpoint status
            ```bash
            sudo -u etcd ETCDCTL_API=3 /opt/etcd/etcd-v3.3.7-linux-amd64/etcdctl -w table endpoint status \
              --endpoints=https://127.0.0.1:2379 \
              --cacert=/opt/etcd/ssl/ca.pem \
              --cert=/opt/etcd/ssl/kube-master01.vagrant.example.pem \
              --key=/opt/etcd/ssl/kube-master01.vagrant.example-key.pem
            ```
         1. List cluster status
            ```bash
            sudo -u etcd ETCDCTL_API=3 /opt/etcd/etcd-v3.3.7-linux-amd64/etcdctl -w table endpoint --cluster status \
              --endpoints=https://127.0.0.1:2379 \
              --cacert=/opt/etcd/ssl/ca.pem \
              --cert=/opt/etcd/ssl/kube-master01.vagrant.example.pem \
              --key=/opt/etcd/ssl/kube-master01.vagrant.example-key.pem
            ```
1. execute `ansible-playbook -i inventory/vagrant.ini site.yml -k -K -u vagrant --tags=master` to install the kube-apiserver
   1. prompts triggered by the `ansible-playbook` command
      1. ssh password: `vagrant`
      1. sudo password: `vagrant`