resource "aws_subnet" "web_public" {
  vpc_id            = var.vpc_id
  cidr_block        = var.cidr_block
  availability_zone = var.availability_zone

  tags = {
    Name = "sds-midterm-subnet-web-public"
  }
}

# TODO: remove 22?
resource "aws_security_group" "sg_web" {
  name        = "sg_web"
  description = "Security group for the web server"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow inbound traffic on port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow inbound traffic on port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "sds-midterm-sg-web"
  }
}

resource "aws_network_interface" "web_public" {
  subnet_id       = aws_subnet.web_public.id
  security_groups = [aws_security_group.sg_web.id]

  tags = {
    Name = "sds-midterm-eni-web-public"
  }
}

resource "aws_instance" "web_server" {
  ami               = var.ami
  instance_type     = var.instance_type
  availability_zone = var.availability_zone

  network_interface {
    network_interface_id = aws_network_interface.web_public.id
    device_index         = 0
  }

  user_data = templatefile("init-wordpress.tftpl", {
    database_name = var.database_name
    database_user = var.database_user
    database_pass = var.database_pass
    database_host = var.database_host
    admin_user    = var.admin_user
    admin_pass    = var.admin_pass
  })

  tags = {
    Name = "Web Server"
  }
}

# TODO: remove this later
output "web_server_public_ip" {
  value = aws_instance.web_server.public_ip
}
