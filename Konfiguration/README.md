## Kubernetes Configuration

### kube-controller-manager
1. The kube-controller-manager needs to have configuration attached to it so that it knows how to connect to the API server
   1. To generate the configuration using the vagrant setup run the following 4 commands in the `Konfiguration/vagrant` directory
      ```bash
         kubectl config set-cluster kube-vagrant \
            --certificate-authority=../../Certificates/vagrant/out/ca.pem \
            --embed-certs=true \
            --server=https://127.0.0.1:6443 \
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
      1. Results in
         * kube-controller-manager.kubeconfig

### kube-scheduler
1. The kube-scheduler needs to have configuration attached to is to that it knows hot to connect to the API server
   1. To generate the configuration using the vagrant setup run the following 4 commands in the `Konfiguration/vagrant` directory
      ```bash
         kubectl config set-cluster kube-vagrant \
            --certificate-authority=../../Certificates/vagrant/out/ca.pem \
            --embed-certs=true \
            --server=https://127.0.0.1:6443 \
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
      1. Results in
         * kube-scheduler.kubeconfig

### master-admin
1. The master admin configuration needs to be created for local use on each master machine for debugging and local configuration tasks
   1. To Generate the configuration using the vagrant setup run the following 4 commands in the `Konfiguration/vagant` directory
      ```bash
         kubectl config set-cluster kube-vagrant \
            --certificate-authority=../../Certificates/vagrant/out/ca.pem \
            --embed-certs=true \
            --server=https://127.0.0.1:6443 \
            --kubeconfig=master-admin.kubeconfig
         #TODO need to get a load balancer setup that proxy https requests to the api server rather than just localhost
         kubectl config set-credentials admin \
            --client-certificate=../../Certificates/vagrant/out/admin.pem \
            --client-key=../../Certificates/vagrant/out/admin-key.pem \
            --embed-certs=true \
            --kubeconfig=master-admin.kubeconfig
        
         kubectl config set-context default \
            --cluster=kube-vagrant \
            --user=admin \
            --kubeconfig=master-admin.kubeconfig
            
         kubectl config use-context default --kubeconfig=master-admin.kubeconfig
      ```
      1. Results in
         * master-admin.kubeconfig
         
### kubelet (worker nodes)
1. Setup kubeconfig for each worker node
   1. To Generate the configuration using the vagrant setup run the following 4 commands in the `Konfiguration/vagrant` directory
      ```bash
         for instance in kube-worker01 kube-worker02; do
            kubectl config set-cluster kube-vagrant \
               --certificate-authority=../../Certificates/vagrant/out/ca.pem \
               --embed-certs=true \
               --server=https://192.168.50.10:6443 \
               --kubeconfig=${instance}.kubeconfig
            #TODO need to get a load balancer setup that proxy https requests to the api server rather than just localhost
            kubectl config set-credentials system:node:${instance} \
               --client-certificate=../../Certificates/vagrant/out/${instance}.vagrant.example.pem \
               --client-key=../../Certificates/vagrant/out/${instance}.vagrant.example-key.pem \
               --embed-certs=true \
               --kubeconfig=${instance}.kubeconfig
         
            kubectl config set-context default \
               --cluster=kube-vagrant \
               --user=system:node:${instance} \
               --kubeconfig=${instance}.kubeconfig
         
            kubectl config use-context default --kubeconfig=${instance}.kubeconfig
         done
      ```
      1. Results in
         * kube-worker01.vagrant.example.kubeconfig
         * kube-worker02.vagrant.example.kubeconfig
         
### kube-proxy
1. Setup kube-proxy configuration
   1. To Generate the configuration using the vagrant setup run the following 4 commands in the `Konfiguration\vagrant` directory
      ```bash
         kubectl config set-cluster kube-vagrant \
            --certificate-authority=../../Certificates/vagrant/out/ca.pem \
            --embed-certs=true \
            --server=https://192.168.50.10:6443 \
            --kubeconfig=kube-proxy.kubeconfig
         
         kubectl config set-credentials system:kube-proxy \
            --client-certificate=../../Certificates/vagrant/out/kube-proxy.pem \
            --client-key=../../Certificates/vagrant/out/kube-proxy-key.pem \
            --embed-certs=true \
            --kubeconfig=kube-proxy.kubeconfig
         
         kubectl config set-context default \
            --cluster=kube-vagrant \
            --user=system:kube-proxy \
            --kubeconfig=kube-proxy.kubeconfig
         
         kubectl config use-context default --kubeconfig=kube-proxy.kubeconfig
      ```
      1. Results in
         * kube-proxy.kubeconfig
         
### remote admin
1. The kubectl admin configuration needs to be created for remote use to manage the cluster
   1. To Generate the configuration using the vagrant setup run the following 4 commands in the `Konfiguration/vagant` directory
      ```bash
         kubectl config set-cluster kube-vagrant \
            --certificate-authority=../../Certificates/vagrant/out/ca.pem \
            --embed-certs=true \
            --server=https://192.168.50.10 \
            --kubeconfig=remote-admin.kubeconfig
         #TODO need to get a load balancer setup that proxy https requests to the api server rather than just localhost
         kubectl config set-credentials admin \
            --client-certificate=../../Certificates/vagrant/out/admin.pem \
            --client-key=../../Certificates/vagrant/out/admin-key.pem \
            --embed-certs=true \
            --kubeconfig=remote-admin.kubeconfig
        
         kubectl config set-context default \
            --cluster=kube-vagrant \
            --user=admin \
            --kubeconfig=remote-admin.kubeconfig
            
         kubectl config use-context default --kubeconfig=remote-admin.kubeconfig
        ```
      1. Results in
         * remote-admin.kubeconfig