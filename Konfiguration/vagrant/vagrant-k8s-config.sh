#!/usr/bin/env bash

rm -f *.kubeconfig

### kube-controller-manager
kubectl config set-cluster kube-vagrant \
   --certificate-authority=../../Certificates/vagrant/out/ca.pem \
   --embed-certs=true \
   --server=https://127.0.0.1:6443 \
   --kubeconfig=kube-controller-manager.kubeconfig
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

### kube-scheduler
kubectl config set-cluster kube-vagrant \
   --certificate-authority=../../Certificates/vagrant/out/ca.pem \
   --embed-certs=true \
   --server=https://127.0.0.1:6443 \
   --kubeconfig=kube-scheduler.kubeconfig
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

### master-admin
kubectl config set-cluster kube-vagrant \
   --certificate-authority=../../Certificates/vagrant/out/ca.pem \
   --embed-certs=true \
   --server=https://127.0.0.1:6443 \
   --kubeconfig=master-admin.kubeconfig
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

### remote admin
kubectl config set-cluster kube-vagrant \
   --certificate-authority=../../Certificates/vagrant/out/ca.pem \
   --embed-certs=true \
   --server=https://192.168.50.10 \
   --kubeconfig=remote-admin.kubeconfig
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

### kubelet (worker nodes)
for instance in worker01 worker02; do
   kubectl config set-cluster kube-vagrant \
      --certificate-authority=../../Certificates/vagrant/out/ca.pem \
      --embed-certs=true \
      --server=https://192.168.50.10:6443 \
      --kubeconfig=${instance}.kubeconfig
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

### kube-router
kubectl config set-cluster kube-vagrant \
   --certificate-authority=../../Certificates/vagrant/out/ca.pem \
   --embed-certs=true \
   --server=https://192.168.50.10:6443 \
   --kubeconfig=kube-router.kubeconfig
kubectl config set-credentials kube-router \
   --client-certificate=../../Certificates/vagrant/out/kube-router.vagrant.example.pem \
   --client-key=../../Certificates/vagrant/out/kube-router.vagrant.example-key.pem \
   --embed-certs=true \
   --kubeconfig=kube-router.kubeconfig
kubectl config set-context default \
   --cluster=kube-vagrant \
   --user=kube-router \
   --kubeconfig=kube-router.kubeconfig
kubectl config use-context default --kubeconfig=kube-router.kubeconfig

### Configuring kubectl for Remote Access
kubectl config set-cluster kube-vagrant \
  --certificate-authority=../../Certificates/vagrant/out/ca.pem \
  --embed-certs=true \
  --server=https://192.168.50.10:6443
kubectl config set-credentials admin \
  --client-certificate=../../Certificates/vagrant/out/admin.pem \
  --embed-certs=true \
  --client-key=../../Certificates/vagrant/out/admin-key.pem
kubectl config set-context kube-vagrant \
  --cluster=kube-vagrant \
  --user=admin
kubectl config use-context kube-vagrant