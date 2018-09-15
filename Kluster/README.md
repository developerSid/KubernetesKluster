#Kluster
Defines a set of virtual machines that are to be used to deploy a Kubernetes Cluster to.  Once a cluster has been brought up
you will need to provision them with the required tools using Ansible via the *Provision* directory

## Vagrant
You'll need
1. [Virtualbox](https://www.virtualbox.org)
1. [Vagrant](https://www.vagrantup.com)

### Six Node Cluster
This is a largish cluster to demonstrate high availability and greater than 1 worker node.  It consists of
* 1 Load Balancer (uses HAProxy)
  * Consumes 1/2 gig of RAM
* 3 Control Plane nodes (etcd, components required for the Kubernetes Control plane)
  * Each consumes 2 gigs of RAM for a total of (6 gigs of RAM)
* 2 Worker nodes (kubelet, other components required for a Kubernetes Workers)
  * Each consumes 2 gigs of RAM for a total of (4 gigs of RAM)

_Make sure you have enough processing power to run this thing_
_This cluster is the one I developed this project with in mind, but have had trouble with the masters consuming more 
CPU than I had hoped they would, resulting in larger VM requirements.  I still believe this is the most valuable of 
the 2 vagrant virtualbox based clusters as it simulates a real system better, but it does require a pretty beefy 
machine to run._

#### Operate
1. `cd Kluster/vagrant/virtualbox/sixnode`
1. Bring up
   1. `vagrant up`
1. Bring down
   1. `vagrant halt`
1. Clean up
   1. `vagrant destroy`
1. Snapshot management (useful for trying things out)
   1. Take snap shot
      1. `vagrant snapshot save YOUR-SNAPSHOT-NAME`
   1. Restore a snap shot
      1. `vagrant snapshot restore YOUR-SNAPSHOT-NAME`
   
### Three Node Cluster
This Cluster is a smaller development type cluster that is useful for learning concepts and consists of 
* 1 Load Balancer (uses HAProxy)
  * Consumes 1/2 gig of RAM
* 1 Control Plane nodes (etcd, components required for the Kubernetes Control plane)
  * Consumes 2 gigs of RAM
* 1 Worker node (kubelet, other components required for a Kubernetes Workers)
  * Consumes 2 gigs of RAM
  
#### Operate
1. `cd Kluster/vagrant/virtualbox/twonode`
1. Bring up
   1. `vagrant up`
1. Bring down
   1. `vagrant halt`
1. Clean up
   1. `vagrant destroy`
1. Snapshot management (useful for trying things out)
   1. Take snap shot
      1. `vagrant snapshot save YOUR-SNAPSHOT-NAME`
   1. Restore a snap shot
      1. `vagrant snapshot restore YOUR-SNAPSHOT-NAME`
1. SSH into VM's
   1. `vagrant ssh lb01`
   1. `vagrant ssh master01`
   1. `vagrant ssh worker01`