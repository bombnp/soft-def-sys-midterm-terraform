resource "aws_subnet" "db_private" {
  vpc_id            = var.vpc_id
  cidr_block        = var.cidr_block
  availability_zone = var.availability_zone

  tags = {
    Name = "sds-midterm-subnet-db-private"
  }
}

resource "aws_route_table" "db_rtb" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
    Name = "sds-midterm-db-rtb"
  }
}

resource "aws_route_table_association" "db_rtb" {
  subnet_id      = aws_subnet.db_private.id
  route_table_id = aws_route_table.db_rtb.id
}

# TODO: restrict db access to our subnet only
resource "aws_security_group" "sg_db" {
  name        = "sg_db"
  description = "Security group for the database"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow inbound traffic on port 3306"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow inbound traffic on port 22"
    from_port   = 22
    to_port     = 22
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
    Name = "sds-midterm-sg-db"
  }
}

resource "aws_network_interface" "db_private" {
  subnet_id       = aws_subnet.db_private.id
  security_groups = [aws_security_group.sg_db.id]

  tags = {
    Name = "sds-midterm-eni-db-private"
  }
}

# TODO: remove this later
resource "aws_eip" "db_eip" {
  vpc               = true
  network_interface = aws_network_interface.db_private.id

  tags = {
    Name = "sds-midterm-eip-db"
  }
}

resource "aws_instance" "db_server" {
  # TODO: remove this later
  depends_on = [
    aws_eip.db_eip
  ]

  ami               = var.ami
  instance_type     = var.instance_type
  availability_zone = var.availability_zone

  network_interface {
    network_interface_id = aws_network_interface.db_private.id
    device_index         = 0
  }

  user_data = templatefile("init-db.tftpl", {
    database_name = var.database_name
    database_user = var.database_user
    database_pass = var.database_pass
  })

  tags = {
    Name = "sds-midterm-db-server"
  }
}

output "db_server_private_ip" {
  value = aws_instance.db_server.private_ip
}

output "db_server_public_ip" {
  value = aws_instance.db_server.public_ip
}
