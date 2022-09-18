resource "aws_vpc" "vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "sds-midterm-vpc"
  }
}

module "internal" {
  source = "./subnets/internal"

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "172.16.0.0/24"
  availability_zone = var.availability_zone
}

module "db_private" {
  source = "./subnets/db_private"

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "172.16.1.0/24"
  availability_zone = var.availability_zone
}

module "web_public" {
  source = "./subnets/web_public"

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "172.16.2.0/24"
  availability_zone = var.availability_zone
}
