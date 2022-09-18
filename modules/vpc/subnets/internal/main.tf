resource "aws_subnet" "internal" {
  vpc_id            = var.vpc_id
  cidr_block        = var.cidr_block
  availability_zone = var.availability_zone

  tags = {
    Name = "sds-midterm-subnet-internal"
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
