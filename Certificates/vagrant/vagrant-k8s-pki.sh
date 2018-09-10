#!/usr/bin/env bash

rm -rf out
mkdir -p out
cd out
cfssl gencert -initca ../in/ca-csr.json | cfssljson -bare ca -
../in/encryption-config.sh
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=../in/ca-config.json -profile=kubernetes ../in/master.vagrant.example-server.json | cfssljson -bare master.vagrant.example
ssh-keygen -t rsa -N "" -f ./rke.key