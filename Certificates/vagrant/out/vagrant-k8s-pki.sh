#!/usr/bin/env bash

cfssl gencert -initca ../in/ca-csr.json | cfssljson -bare ca -
../in/encryption-config.sh
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=../in/ca-config.json -profile=etcd ../in/kube-master01-etcd.vagrant.example-server.json | cfssljson -bare kube-master01-etcd.vagrant.example
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=../in/ca-config.json -profile=etcd ../in/kube-master02-etcd.vagrant.example-server.json | cfssljson -bare kube-master02-etcd.vagrant.example
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=../in/ca-config.json -profile=etcd ../in/kube-master03-etcd.vagrant.example-server.json | cfssljson -bare kube-master03-etcd.vagrant.example
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=../in/ca-config.json -profile=kubernetes ../in/kube-master.vagrant.example-server.json | cfssljson -bare kube-master.vagrant.example
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=../in/ca-config.json -profile=kubernetes ../in/service-account-csr.json | cfssljson -bare service-account
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=../in/ca-config.json -profile=kubernetes ../in/kube-controller-manager-csr.json | cfssljson -bare kube-controller-manager
cfssl gencert -ca=ca.pem  -ca-key=ca-key.pem  -config=../in/ca-config.json  -profile=kubernetes ../in/kube-scheduler-csr.json | cfssljson -bare kube-scheduler
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=../in/ca-config.json -profile=kubernetes ../in/kube-proxy-csr.json | cfssljson -bare kube-proxy
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=../in/ca-config.json -profile=kubernetes ../in/admin-csr.json | cfssljson -bare admin
