#!/bin/bash

# Update packages and install utilities
sudo yum update -y
sudo yum install -y jq git python3 docker maven

# Install Node.js 16
curl -sL https://rpm.nodesource.com/setup_16.x | sudo bash -
sudo yum install -y nodejs

# Install Amazon Corretto (Java 11)
sudo yum install -y java-11-amazon-corretto-devel

# Install Terraform
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum install -y terraform

# Install kubectl
curl -LO https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm -f kubectl

# Install eksctl
ARCH=amd64  # Set to `arm64` if you are using an ARM-based system
PLATFORM=$(uname -s)_$ARCH

curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"

# (Optional) Verify checksum
curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt" | grep $PLATFORM | sha256sum --check

tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz
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

# Show versions to confirm installation
echo "=== Package Versions ==="
echo "Terraform:" && terraform -v
echo "kubectl:" && kubectl version --client --short
echo "eksctl:" && eksctl version
echo "Helm:" && helm version --short
echo "Git:" && git --version
echo "Python:" && python3 --version
echo "Node.js:" && node -v
echo "npm:" && npm -v
echo "Docker:" && docker --version
echo "Maven:" && mvn -v
echo "Java:" && java -version
echo "AWS CLI:" && aws --version
echo "========================"
