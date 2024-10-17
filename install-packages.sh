#!/bin/bash

# Update packages and install utilities
sudo yum update -y
sudo yum install -y jq git python3 docker java-11-openjdk-devel maven

# Install Node.js 16
curl -sL https://rpm.nodesource.com/setup_16.x | sudo bash -
sudo yum install -y nodejs

# Install Terraform
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum install -y terraform

# Install kubectl
curl -LO https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm -f kubectl

# Install eksctl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/$(curl --silent "https://api.github.com/repos/weaveworks/eksctl/releases/latest" | jq -r .tag_name)/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin

# Install Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Install Git-CodeCommit credential helper
sudo yum install -y aws-cli
git config --global credential.helper '!aws codecommit credential-helper $@'
git config --global credential.UseHttpPath true

# Enable Docker service
sudo systemctl enable docker
sudo systemctl start docker
