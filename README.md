# tf-operator-deployer
tf-operator based deployment of tungsten CNI

## Roll-Out Operator based installation
initialise and run tf-operator

<b>Prelude:</b> It is assumed that the Kubernetes(kubelet kubeadm kubectl) is installed and kernel headers are available on the node. if not, use the scripts available in the helper directory to install Kubernetes and kernel headers. Make sure you have configured hosts file on each node.

```
vim /etc/hosts
#Add the following lines:
<ip-address> <master-node-hostname>
<ip-address> <worker-node-hostname>
```
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

tf operator assumes to enable tungsten fabric controller on master nodes only and datapath on all the nodes.

Once everything is ready the cluster can be rolled out using
```
kubectl create -f deploy/sample_deployment.yaml
```


