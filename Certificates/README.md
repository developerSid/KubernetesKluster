# Certs for the cluster

## Rancher cluster
Only the ssh key is needed.  This key will be used by the ansible script when setting up the kubernetes user on the 
different machines.
1. Make sure OpenSSH is installed on your machine
1. Execute `./vagrant-k8s-pki.sh` to generate
   1. *rke.key*
   1. *rke.key.pub*
