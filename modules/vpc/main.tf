resource "aws_vpc" "vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "sds-midterm-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "sds-midterm-igw"
  }
}

resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "sds-midterm-rtb"
  }
}

resource "aws_main_route_table_association" "main_rtb" {
  vpc_id         = aws_vpc.vpc.id
  route_table_id = aws_route_table.rtb.id
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
  ami               = var.ami
  instance_type     = var.instance_type

  database_name = var.database_name
  database_user = var.database_user
  database_pass = var.database_pass
}

module "web_public" {
  source = "./subnets/web_public"

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "172.16.2.0/24"
  availability_zone = var.availability_zone
  ami               = var.ami
  instance_type     = var.instance_type

  database_name = var.database_name
  database_user = var.database_user
  database_pass = var.database_pass
  database_host = module.db_private.db_server_private_ip

  admin_user = var.admin_user
  admin_pass = var.admin_pass
}

# TODO: temporary, remove this later
output "web_server_public_ip" {
  value = module.web_public.web_server_public_ip
}

output "db_server_public_ip" {
  value = module.db_private.db_server_public_ip
}
