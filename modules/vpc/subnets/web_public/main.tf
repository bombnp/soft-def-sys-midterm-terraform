resource "aws_subnet" "web_public" {
  vpc_id            = var.vpc_id
  cidr_block        = var.cidr_block
  availability_zone = var.availability_zone

  tags = {
    Name = "sds-midterm-subnet-web-public"
  }
}

resource "aws_network_interface" "web_public" {
  subnet_id = aws_subnet.web_public.id

  tags = {
    Name = "sds-midterm-eni-web-public"
  }
}
