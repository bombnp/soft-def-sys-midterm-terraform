resource "aws_vpc" "vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "sds-midterm-vpc"
  }
}

resource "aws_subnet" "web_public" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "172.16.0.0/24"
  availability_zone = var.availability_zone

  tags = {
    Name = "sds-midterm-subnet-web-public"
  }
}

resource "aws_subnet" "internal" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "172.16.1.0/24"
  availability_zone = var.availability_zone

  tags = {
    Name = "sds-midterm-subnet-internal"
  }
}

resource "aws_subnet" "db_private" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "172.16.2.0/24"
  availability_zone = var.availability_zone

  tags = {
    Name = "sds-midterm-subnet-db-private"
  }
}

resource "aws_network_interface" "web_public" {
  subnet_id = aws_subnet.web_public.id

  tags = {
    Name = "sds-midterm-eni-web-public"
  }
}

resource "aws_network_interface" "internal_web" {
  subnet_id = aws_subnet.internal.id

  tags = {
    Name = "sds-midterm-eni-internal-web"
  }
}

resource "aws_network_interface" "internal_db" {
  subnet_id = aws_subnet.internal.id

  tags = {
    Name = "sds-midterm-eni-internal-db"
  }
}

resource "aws_network_interface" "db_private" {
  subnet_id = aws_subnet.db_private.id

  tags = {
    Name = "sds-midterm-eni-db-private"
  }
}
