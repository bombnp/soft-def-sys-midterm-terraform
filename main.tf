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

module "ec2-instances" {
  source = "./modules/ec2-instances"

  ami               = var.ami
  availability_zone = var.availability_zone
  instance_type     = var.instance_type
}
