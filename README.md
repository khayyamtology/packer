# Packer Custom AMI Setup with Automated Package Installation

This repository contains a Packer configuration and a shell script to build a custom Amazon Linux AMI with pre-installed tools and utilities. The goal is to automate the creation of an AMI that includes essential development and operational tools like `terraform`, `kubectl`, `eksctl`, `helm`, `git`, `python3`, `docker`, `maven`, `node`, and more.

## Prerequisites

Before you begin, ensure you have the following installed:
- [Packer](https://www.packer.io/downloads)
- AWS CLI configured with access to your AWS account ([AWS CLI Configuration Guide](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html))
- Sufficient IAM permissions to create AMIs, EC2 instances, and VPC resources in AWS.

## Steps to Create the Custom AMI

### Step 1: Clone the Repository
Clone the repository to your local machine:
```bash
git clone https://github.com/your-username/your-repository.git
cd your-repository
```

### Step 2: Update Packer Configuration
The Packer configuration file (aws-al2023.pkr.hcl) is pre-configured to use the install-packages.sh script. Update the vpc_id, subnet_id, and other variables if necessary to match your AWS environment.

### Step 3: Customize the install-packages.sh Script
The script installs a set of tools by default. Feel free to add or modify packages based on your requirements. The following tools are installed using the install-packages.sh script:
To ensure the script runs correctly, make it executable by running: chmod +x install-packages.sh

```bash
Terraform
kubectl
eksctl
Helm
Git
Python3
Docker
Maven:
Node.js & npm
AWS CLI
```
### Example Output

```bash
=== Package Versions ===
Terraform: v1.9.8
kubectl: v1.27.3
eksctl: 0.193.0
Helm: v3.16.2
Git: git version 2.40.1
Python: Python 3.9.16
Node.js: v16.20.2
npm: 8.19.4
Docker: Docker version 25.0.5, build 5dc9bcc
Maven: Apache Maven 3.8.4 (Red Hat 3.8.4-3.amzn2023.0.5)
Java: OpenJDK 17.0.12
AWS CLI: aws-cli/2.15.30
========================
```

### Step 4: Build the AMI Using Packer
Run the following Packer command to build your custom AMI:

```bash
packer init aws-al2023.pkr.hcl
packer build aws-al2023.pkr.hcl
```
This will create an AMI with all the packages pre-installed. Make sure you have provided correct VPC and Subnet IDs in the .pkr.hcl file.
