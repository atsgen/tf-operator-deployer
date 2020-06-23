# tf-operator-deployer
tf-operator based deployment of tungsten CNI

## Kubernetes installation
Among the various kubernetes installation methods available, we have helper scripts
available as a reference for installation of k8s components needed to init master
or join a k8s node in the cluster

## Prerequisite
Operator builds the vrouter kernel module during deployment and thus requires relavant
kernel headers to be pre installed on all the nodes
Centos
```
sudo yum install -y kernel-devel-$(uname -r)
```
Ubuntu
```
sudo apt-get install -y linux-headers-$(uname -r)
```

## Roll-Out Operator based installation
initialise and run tf-operator
```
# assumed to be executed from within the top level of repo
# get container image for operator
./get_operator_image.sh

kubectl create -f deploy/001_namespace.yaml
kubectl create -f deploy/002_service_account.yaml
kubectl create -f deploy/003_role.yaml
kubectl create -f deploy/004_role_binding.yaml
# default password set as 'atsgen'
# user can choose to skip creating secret from here and define
# there own password using
# kubectl create secret generic -n atsgen tungsten-auth --from-literal=password='atsgen'
kubectl create -f deploy/005_secret.yaml
kubectl create -f deploy/006_crd.yaml
kubectl create -f deploy/operator.yaml
```

tf operator automatically assigns tungsten fabric controller role to master nodes and datapath components
are assigned to all the nodes in the cluster

Once everything is ready, the cluster can be rolled out using the following command
```
kubectl create -f deploy/sample_deployment.yaml
```


