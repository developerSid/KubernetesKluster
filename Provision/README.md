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
                  --cert=/opt/etcd/ssl/master01-etcd.vagrant.example.pem \
                  --key=/opt/etcd/ssl/master01-etcd.vagrant.example-key.pem
            ```
         1. List the health of the cluster
            ```bash
               sudo -u etcd ETCDCTL_API=3 /opt/etcd/etcd-v3.3.7-linux-amd64/etcdctl endpoint --cluster health \
                  --endpoints=https://127.0.0.1:2379 \
                  --cacert=/opt/etcd/ssl/ca.pem \
                  --cert=/opt/etcd/ssl/master01-etcd.vagrant.example.pem \
                  --key=/opt/etcd/ssl/master01-etcd.vagrant.example-key.pem
            ```
         1. List endpoint status
            ```bash
               sudo -u etcd ETCDCTL_API=3 /opt/etcd/etcd-v3.3.7-linux-amd64/etcdctl -w table endpoint status \
                  --endpoints=https://127.0.0.1:2379 \
                  --cacert=/opt/etcd/ssl/ca.pem \
                  --cert=/opt/etcd/ssl/master01-etcd.vagrant.example.pem \
                  --key=/opt/etcd/ssl/master01-etcd.vagrant.example-key.pem
            ```
         1. List cluster status
            ```bash
               sudo -u etcd ETCDCTL_API=3 /opt/etcd/etcd-v3.3.7-linux-amd64/etcdctl -w table endpoint --cluster status \
                  --endpoints=https://127.0.0.1:2379 \
                  --cacert=/opt/etcd/ssl/ca.pem \
                  --cert=/opt/etcd/ssl/master01-etcd.vagrant.example.pem \
                  --key=/opt/etcd/ssl/master01-etcd.vagrant.example-key.pem
            ```
1. execute `ansible-playbook -i inventory/vagrant.ini site.yml -k -K -u vagrant --tags=master` to install the kube-apiserver
   1. prompts triggered by the `ansible-playbook` command
      1. ssh password: `vagrant`
      1. sudo password: `vagrant`
1. check that the control plane is operational
   1. First need to login to one of the master machines
      1. Change directory to _Kluster_
      1. Then `vagrant ssh master01`
   1. Then execute a kubectl command
      1. `sudo -u kubernetes /opt/kubernetes/kubernetes-v1.10.4-linux-amd64/bin/kubectl get componentstatuses -o=wide --kubeconfig /opt/kubernetes/config/master-admin.kubeconfig`
         1. should see something like
         ```text
            NAME                 STATUS    MESSAGE             ERROR
            controller-manager   Healthy   ok
            scheduler            Healthy   ok
            etcd-0               Healthy   {"health":"true"}
            etcd-1               Healthy   {"health":"true"}
            etcd-2               Healthy   {"health":"true"}
         ```
1. execute `ansible-playbook -i inventory/vagrant.ini site.yml -k -u vagrant --tags=worker` to install all the components for the worker machines
   1. prompts triggered by the `ansible-playbook` command
      1. ssh password: `vagrant`
1. Need to configure the node's access.  Change directory to the Kluster directory and execute `vagrant ssh master01`
   1. execute 
```bash
sudo -u kubernetes cat <<EOF | sudo -u kubernetes /opt/kubernetes/kubernetes-v1.10.4-linux-amd64/bin/kubectl apply --kubeconfig /opt/kubernetes/config/master-admin.kubeconfig -f -
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRole
metadata:
  annotations:
    rbac.authorization.kubernetes.io/autoupdate: "true"
  labels:
    kubernetes.io/bootstrapping: rbac-defaults
  name: system:kube-apiserver-to-kubelet
rules:
  - apiGroups:
      - ""
    resources:
      - nodes/proxy
      - nodes/stats
      - nodes/log
      - nodes/spec
      - nodes/metrics
    verbs:
      - "*"
EOF
```
      1. According to Kubernetes the Hard Way this should have the effect of "Create the system:kube-apiserver-to-kubelet 
         ClusterRole with permissions to access the Kubelet API and perform most common tasks associated with managing pods"
   1. execute
```bash
sudo -u kubernetes cat <<EOF | sudo -u kubernetes /opt/kubernetes/kubernetes-v1.10.4-linux-amd64/bin/kubectl apply --kubeconfig /opt/kubernetes/config/master-admin.kubeconfig -f -
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: system:kube-apiserver
  namespace: ""
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: system:kube-apiserver-to-kubelet
subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: User
    name: kubernetes
EOF
```
      1. "Bind the system:kube-apiserver-to-kubelet ClusterRole to the kubernetes user"