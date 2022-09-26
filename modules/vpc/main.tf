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

module "internal" {
  source = "./subnets/internal"

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "172.16.0.0/24"
  availability_zone = var.availability_zone
}

module "db_private" {
  source = "./subnets/db_private"

  # TODO: remove this since db does not need EIP
  # explicit dependency is needed for the EIP to wait for IGW
  depends_on = [
    aws_internet_gateway.igw
  ]

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "172.16.1.0/24"
  availability_zone = var.availability_zone
  igw_id            = aws_internet_gateway.igw.id
  internal_eni_id   = module.internal.internal_db_eni_id
  ami               = var.ami
  instance_type     = var.instance_type

  database_name = var.database_name
  database_user = var.database_user
  database_pass = var.database_pass
}

module "web_public" {
  source = "./subnets/web_public"

  # explicit dependency is needed for the EIP to wait for IGW. Also wait for db module
  depends_on = [
    aws_internet_gateway.igw,
    module.db_private
  ]

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "172.16.2.0/24"
  availability_zone = var.availability_zone
  igw_id            = aws_internet_gateway.igw.id
  internal_eni_id   = module.internal.internal_web_eni_id
  ami               = var.ami
  instance_type     = var.instance_type

  database_name = var.database_name
  database_user = var.database_user
  database_pass = var.database_pass
  database_host = module.internal.internal_db_private_ip

  admin_user = var.admin_user
  admin_pass = var.admin_pass

  iam_s3_access_key = var.iam_s3_access_key
  iam_s3_secret_key = var.iam_s3_secret_key
  bucket_name       = var.bucket_name
  bucket_region     = var.bucket_region
}

# TODO: temporary, remove this later
output "web_server_public_ip" {
  value = module.web_public.web_server_public_ip
}

output "db_server_public_ip" {
  value = module.db_private.db_server_public_ip
}

output "db_server_internal_ip" {
  value = module.internal.internal_db_private_ip
}
