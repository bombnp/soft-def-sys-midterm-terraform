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

# module "vpc" {
#   source = "./modules/vpc"

#   availability_zone = var.availability_zone
# }

module "ec2_instances" {
  source = "./modules/ec2_instances"

  ami               = var.ami
  availability_zone = var.availability_zone
  instance_type     = var.instance_type

  database_name = var.database_name
  database_user = var.database_user
  database_pass = var.database_pass
  admin_user    = var.admin_user
  admin_pass    = var.admin_pass
}

# TODO: temporary, remove this later
output "web_server_public_ip" {
  value = module.ec2_instances.web_server_public_ip
}

output "db_server_public_ip" {
  value = module.ec2_instances.db_server_public_ip
}
