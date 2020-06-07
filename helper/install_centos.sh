#!/bin/bash

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

sudo yum install -y docker-ce docker-ce-cli containerd.io

sudo yum install -y kernel-devel-$(uname -r)
sudo yum install iptables
sudo yum install -y kubelet kubeadm kubectl
systemctl enable kubelet
systemctl start kubelet

sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/g' /etc/selinux/config

echo "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.conf
echo "net.bridge.bridge-nf-call-iptables=1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
sudo modprobe br_netfilter
sudo systemctl start docker.service
sudo systemctl enable docker.service

# setup nodes based on thier roles
#sudo kubeadm init
