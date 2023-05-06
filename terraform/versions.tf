terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.65"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.9"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.20"
    }
  }
}
