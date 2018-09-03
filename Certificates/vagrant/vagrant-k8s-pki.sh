#!/usr/bin/env bash

rm -rf out
mkdir -p out
cd out
cfssl gencert -initca ../in/ca-csr.json | cfssljson -bare ca -
../in/encryption-config.sh
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=../in/ca-config.json -profile=etcd ../in/master01-etcd.vagrant.example-server.json | cfssljson -bare master01-etcd.vagrant.example
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=../in/ca-config.json -profile=etcd ../in/master02-etcd.vagrant.example-server.json | cfssljson -bare master02-etcd.vagrant.example
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=../in/ca-config.json -profile=etcd ../in/master03-etcd.vagrant.example-server.json | cfssljson -bare master03-etcd.vagrant.example
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=../in/ca-config.json -profile=kubernetes ../in/master.vagrant.example-server.json | cfssljson -bare master.vagrant.example
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=../in/ca-config.json -profile=kubernetes ../in/service-account-csr.json | cfssljson -bare service-account
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=../in/ca-config.json -profile=kubernetes ../in/kube-controller-manager-csr.json | cfssljson -bare kube-controller-manager
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=../in/ca-config.json -profile=kubernetes ../in/kube-scheduler-csr.json | cfssljson -bare kube-scheduler
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=../in/ca-config.json -profile=kubernetes ../in/admin-csr.json | cfssljson -bare admin
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=../in/ca-config.json -profile=kubernetes ../in/worker01-csr.json | cfssljson -bare worker01.vagrant.example
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=../in/ca-config.json -profile=kubernetes ../in/worker02-csr.json | cfssljson -bare worker02.vagrant.example
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=../in/ca-config.json -profile=kubernetes ../in/kube-router-csr.json | cfssljson -bare kube-router.vagrant.example
