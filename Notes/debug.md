# Debug

## kubectl

### RBAC
1. Check if a cluster role has been configured correctly.  I am not really sure this is that useful, but it is all that I have found at the moment
   1. `kubectl --kubeconfig=../Konfiguration/vagrant/kube-router.kubeconfig auth reconcile -f roles/master/files/kube-router-cluster-role.yml`
      1. Will probably print `Error from server (Forbidden): clusterroles.rbac.authorization.k8s.io "kube-router" is forbidden: User "kube-router" cannot get clusterroles.rbac.authorization.k8s.io at the cluster scope`
         to indicate failure
   1. `kubectl --kubeconfig=../Konfiguration/vagrant/kube-router.kubeconfig auth reconcile -f roles/master/files/kube-router-cluster-role-binding.yml`
      1. Will probably print `Error from server (Forbidden): clusterrolebindings.rbac.authorization.k8s.io "kube-router" is forbidden: User "kube-router" cannot get clusterrolebindings.rbac.authorization.k8s.io at the cluster scope`
         to indicate still more failure.  Not real sure of the usefulness of this thing
1. Check if kube-router user can do stuff
   1. `kubectl --kubeconfig=../Konfiguration/vagrant/kube-router.kubeconfig auth can-i list nodes`
      1. Should print yes.  Seems to always print no