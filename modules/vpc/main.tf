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
}

module "web_public" {
  source = "./subnets/web_public"

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "172.16.2.0/24"
  availability_zone = var.availability_zone
}
