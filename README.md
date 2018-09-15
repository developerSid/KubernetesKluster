# Kubernetes for cheapskates like me
(NOTE: This cluster doesn't work for for an unknown reason when attempting to setup kube-router, a shift was made to use RKE after this point)
## Setup a Self Hosted Kubernetes cluster _(for learning)_ 

## Why?
To Learn!

## Tools you will need
1. [Virtualbox](https://www.virtualbox.org)
   1. Since I'm using Vagrant, and VirtualBox has the best support for most things this is the easy place to start.
      Someday I would like to support other hypervisors, hopefully I get that done ...
1. [Packer](https://www.packer.io)
   1. This used for building an Ubuntu box to be imported into the Vagrant managed VMs that will make up my test cluster
   1. Double check that the verison of VirtualBox installed is supported by Packer.  I've had issues in with newer 
      versions of packer not working well with older versions of VirtualBox
1. [Vagrant](https://www.vagrantup.com)
   1. For managing the VMs
1. [Ansible](https://docs.ansible.com/ansible/latest/index.html)
   1. Will be used for installing the different components once the VMs have been started via Vagrant
      
## Sections
1. [Build Box](./VMBuild/README.md)
1. [Setup Certificates](./Certificates/README.md)
1. [Start Cluster](./Kluster/README.md)
1. [Install Base Requirements](./Provision/README.md)
1. [Install Kubernetes](./RKE/README.md)


## Further reading
* [Kubernetes Cluster Step by Step](https://icicimov.github.io/blog/kubernetes/Kubernetes-cluster-step-by-step/)
  * need to look into the keepalived and haproxy setup for the api server
    * will want ot run keepalived and haproxy on each node with the VIP that can bounce between
      each node
* [Kubernetes components explained](https://www.cloudfoundry.org/blog/a-look-into-the-kubernetes-master-components/)
* [Kubernetes HA Under X-Ray](https://blog.heptio.com/kubernetes-ha-under-x-ray-5d05f552c9f)

## Cool tricks
* source <(kubectl completion zsh)
  * adds zsh completion
