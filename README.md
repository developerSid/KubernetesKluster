# Setup a Self Hosted Kubernetes cluster _(for learning)_ 

## Why?
To Learn!

## Tools you will need
1. A hypervisor
   1. [Virtualbox](https://www.virtualbox.org)
      1. Since I'm using Vagrant, and VirtualBox has the best support for most things this is the easy place to start.
         I will make an effort later to support other hypervisors.
   1. [Packer](https://www.packer.io)
      1. This used for building an Ubuntu box to be imported into the Vagrant managed VMs that will make up my test cluster
   1. [Vagrant](https://www.vagrantup.com)
      1. For managing the VMs
   