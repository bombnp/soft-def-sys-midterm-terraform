terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"

  availability_zone = var.availability_zone
}

module "ec2_instances" {
  source = "./modules/ec2_instances"

  ami               = var.ami
  availability_zone = var.availability_zone
  instance_type     = var.instance_type
}
