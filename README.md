# Simple REST API in k8s

## Prerequisites
* AWS Public Cloud Account created and have AWS CLI AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY handy
* Install [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) and run `aws configure` to input CLI credentials
* Install [terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli#install-terraform)
* Install [helm](https://helm.sh/docs/intro/install/)
* Install [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl)

## Create Elastic Kubernetes Service (EKS) Cluster using Terraform

Run the following commands to create AWS VPC, Subnets, NAT GW, Internet GW, Security Groups, EKS, IAM roles, IAM role policy attachments, Nodegroup, Run helm to deploy rest-api-in-k8s to EKS, test Classic LB DNS Name to check if API is up.

```shell
cd terraform
terraform init
terraform plan
terraform apply -auto-approve
```
## Continuous Integration and Continuous Delivery/Deployment (CICD)

CI/CD process is configured using Github Actions and you can review the workflow in `.github/workflows/cicd.yml`

Trigger -

1. Change in Dockerfile or in `rest/` folder
2. A Push to `main` branch

