# RBAC

Run the commands here from the root of the project

## kubelet

### Setup kubelet's permissions
1. `kubectl apply -f Konfiguration/vagrant/rbac/kubelet-rbac.yml`

## kube-router

### Setup kube-router's permissions
1. `kubectl apply -f Konfiguration/vagrant/rbac/kube-router-rbac.yml`

### Remove kube-router's permissions
1. `kubectl delete -f Konfiguration/vagrant/rbac/kube-router-rbac.yml`
