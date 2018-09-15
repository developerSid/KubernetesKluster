# vagrant

## basic
1. `vagrant up`
1. `vagrant halt`
1. `vagrant destroy -f`

## snapshots

### Quick snapshots
1. `vagrant snapshot push`
   1. create a snapshot for each VM in the cluster
1. `vagrant snapshot pop --no-delete`
   1. restore all the machines to the state of the snapshot at the top of the stack

### Named snapshots
1. `vagrant snapshot save controlplane`
   1. `vagrant snapshot restore controlplane`
1. `vagrant snapshot save kubelet`
   1. `vagrant snapshot restore kubelet`
