resource "aws_subnet" "db_private" {
  vpc_id            = var.vpc_id
  cidr_block        = var.cidr_block
  availability_zone = var.availability_zone

  tags = {
    Name = "sds-midterm-subnet-db-private"
  }
}

resource "aws_network_interface" "db_private" {
  subnet_id = aws_subnet.db_private.id

  tags = {
    Name = "sds-midterm-eni-db-private"
  }
}
