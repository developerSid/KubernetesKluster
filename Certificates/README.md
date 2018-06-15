# Certs for the cluster

## Tools
1. [cfssl](https://cfssl.org)
   1. need `cfssl` and `cfssljson`

## Cert Generation for the Vagrant based in this repo Kluster steps
1. change directory to /Certificates/vagrant 
1. If you choose to generate them yourself 
   1. The basics of the following files can be generated by
      1. `cfssl print-defaults config > ca-config.json`
      1. `cfssl print-defaults config > ca-csr.json`
1. Generate you Certificate Authority (CA)
   1. `cfssl gencert -initca ca-csr.json | cfssljson -bare ca -`
      * You should be able to use what I have put in the _ca-config.json_
      1. Will result in
         * ca.csr
         * ca.pem
         * ca-key.pem 
1. Will need to update the _ca-csr.json_ with your locality's information
1. Generate server certificates
   1. `cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=server server.json | cfssljson -bare server`
       1. Will Result in
          * server.csr
          * server.pem
          * server-key.pem