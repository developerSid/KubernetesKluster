# Certificates
Contains templates and scripts used for building out the PKI and SSH infrastructure

## Vagrant cluster
Only the ssh key is needed.  This key will be used by the ansible script when setting up the kubernetes user on the 
different machines.
1. Make sure OpenSSH is installed on your machine
1. Execute `./vagrant-k8s-pki.sh` in the *Certificates/vagrant/* directory to generate
   1. *out/rke.key*
   1. *out/rke.key.pub*
