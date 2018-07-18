#!/usr/bin/env bash

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