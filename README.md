# Simple REST API in k8s

## Prerequisites
* Create [AWS Public Cloud Account](https://aws.amazon.com/resources/create-account/)  created and have AWS CLI AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY handy
* Generate [AWS Access Keys](https://us-east-1.console.aws.amazon.com/iamv2/home?region=us-east-2#/security_credentials/access-key-wizard) 
* Create [DockerHub account](https://hub.docker.com/signup) for Pushing and Pulling Docker Images
* Generate [DockerHub Access Tokens](https://hub.docker.com/settings/security) 
* Add generated AWS Access Keys (AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY) and DockerHub Access Token (DOCKER_USR and DOCKER_PWD) to [GitHub Actions Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets)


## Create core AWS resources (VPC, Subnets, NAT, IGW, SG, IAM roles), EKS resources (EKS cluster and EKS nodegroup), and deploy initial version of the app

Navigate to this [GitHub Action](https://github.com/iamsarat/rest-api-in-k8s/actions/workflows/terraform.yml) tab in the repo and choose on `Run Workflow` choice button located in the right-hand side of the browser screen and select `tf_action` as `apply` and click  on `Run Workflow` and when it is finished, you can browse the app by copying `rest_api_in_k8s_url` from the GitHub Action log to your favourite browser tab (Please note, sometimes DNS propagation takes time and you may not be able to access the app url for sometime, so be patient and try again)

## Continuous Integration and Continuous Delivery/Deployment (CICD)

CI/CD process is configured using Github Actions and you can review the workflow in `.github/workflows/cicd.yml`

Trigger -

1. Change in Dockerfile or in `rest/` folder
2. A Push to `main` branch

## Clean Up

Run the following command to destroy all AWS resources created for this exercise -

Navigate to this [GitHub Action](https://github.com/iamsarat/rest-api-in-k8s/actions/workflows/terraform.yml) tab in the repo and choose on `Run Workflow` choice button located in the right-hand side of the browser screen and select `tf_action` as `destroy` and click  on `Run Workflow` and when it is finished, all resources created previously will be erased.
