#The Cluster

## Vagrant

### Six Node Cluster
This is a largish cluster to demonstrate high availability and greater than 1 worker node.  It consists of
* 1 Load Balancer (uses HAProxy)
  * Consumes 1/2 gig of RAM
* 3 Control Plane nodes (etcd, components required for the Kubernetes Control plane)
  * Each consumes 2 gigs of RAM
* 2 Worker nodes (kubelet, other components required for a Kubernetes Workers)
  * Each consumes 2 gigs of RAM

_Make sure you have enough processing power to run this thing_
_This cluster is the one I developed this project with in mind, but have had trouble with the masters consuming more 
CPU than I had hoped they would.  I still believe this is the most valuable of the 2 vagrant virtualbox based clusters
as it simulates a real system better, but it does require a pretty beefy machine to run._
####

### Three Node Cluster
This Cluster is a smaller development type cluster that is useful for learning concepts and consists of 
* 1 Load Balancer/Control Plane Server (uses HAProxy)
  * Consumes 2 gigs of RAM
* 1 Worker Node
  * Consumes 2 gigs or RAM