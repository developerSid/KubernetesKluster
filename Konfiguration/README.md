## Kubernetes Configuration

### kube-controller-manager
1. The kube-controller-manager needs to have configuration attached to it so that it knows how to connect to the API server
   1. To generate the configuration using the vagrant setup run the following 4 commands in the `Konfiguration/vagrant` directory
      ```bash
      kubectl config set-cluster kube-vagrant \
        --certificate-authority=../../Certificates/vagrant/out/ca.pem \
        --embed-certs=true \
        --server=http://127.0.0.1:8080 \
        --kubeconfig=kube-controller-manager.kubeconfig
      #TODO need to get a load balancer setup that proxy https requests to the api server rather than just localhost
      kubectl config set-credentials system:kube-controller-manager \
        --client-certificate=../../Certificates/vagrant/out/kube-controller-manager.pem \
        --client-key=../../Certificates/vagrant/out/kube-controller-manager-key.pem \
        --embed-certs=true \
        --kubeconfig=kube-controller-manager.kubeconfig
    
      kubectl config set-context default \
        --cluster=kube-vagrant \
        --user=system:kube-controller-manager \
        --kubeconfig=kube-controller-manager.kubeconfig
    
      kubectl config use-context default --kubeconfig=kube-controller-manager.kubeconfig
      ```
    1. Will produce `kube-controller-manager.kubeconfig`
1. The kube-scheduler needs to have configuration attached to is to that it knows hot to connect to the API server
   1. To generate the configuration using the vagrant setup run the following 4 commands in the `Konfiguration/vagrant` directory
      ```bash
      kubectl config set-cluster kube-vagrant \
        --certificate-authority=../../Certificates/vagrant/out/ca.pem \
        --embed-certs=true \
        --server=http://127.0.0.1:8080 \
        --kubeconfig=kube-scheduler.kubeconfig
      #TODO need to get a load balancer setup that proxy https requests to the api server rather than just localhost
      kubectl config set-credentials system:kube-scheduler \
        --client-certificate=../../Certificates/vagrant/out/kube-scheduler.pem \
        --client-key=../../Certificates/vagrant/out/kube-scheduler-key.pem \
        --embed-certs=true \
        --kubeconfig=kube-scheduler.kubeconfig
      
      kubectl config set-context default \
        --cluster=kube-vagrant \
        --user=system:kube-scheduler \
        --kubeconfig=kube-scheduler.kubeconfig
      
      kubectl config use-context default --kubeconfig=kube-scheduler.kubeconfig
      ```
1. The admin configuration needs to be created for local use on each master machine for debugging and local configuration tasks
   1. To Generate the configuration using th vagrant setup run the following 4 commands in the `Konfiguration/vagant` directory
      ```bash
         kubectl config set-cluster kubernetes-the-hard-way \
           --certificate-authority=../../Certificates/vagrant/out/ca.pem \
           --embed-certs=true \
           --server=http://127.0.0.1:8080 \
           --kubeconfig=admin.kubeconfig
         #TODO need to get a load balancer setup that proxy https requests to the api server rather than just localhost
         kubectl config set-credentials admin \
           --client-certificate=../../Certificates/vagrant/out/admin.pem \
           --client-key=../../Certificates/vagrant/out/admin-key.pem \
           --embed-certs=true \
           --kubeconfig=admin.kubeconfig
        
         kubectl config set-context default \
           --cluster=kube-vagrant \
           --user=admin \
           --kubeconfig=admin.kubeconfig
        
        kubectl config use-context default --kubeconfig=admin.kubeconfig
        ```