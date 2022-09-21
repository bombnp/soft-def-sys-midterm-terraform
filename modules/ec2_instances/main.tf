resource "aws_instance" "web_server" {
  ami               = var.ami
  instance_type     = var.instance_type
  availability_zone = var.availability_zone

  # TODO: remove this, default vpc
  security_groups = ["launch-wizard-6"]
  user_data = templatefile("init-wordpress.tftpl", {
    database_name = var.database_name
    database_user = var.database_user
    database_pass = var.database_pass
    database_host = aws_instance.db_server.private_ip
    admin_user    = var.admin_user
    admin_pass    = var.admin_pass
  })

  tags = {
    Name = "Web Server"
  }
}

resource "aws_instance" "db_server" {
  ami               = var.ami
  instance_type     = var.instance_type
  availability_zone = var.availability_zone

  # TODO: remove this, default vpc
  security_groups = ["launch-wizard-6"]
  user_data = templatefile("init-db.tftpl", {
    database_name = var.database_name
    database_user = var.database_user
    database_pass = var.database_pass
  })

  tags = {
    Name = "DB Server"
  }
}

output "web_server_public_ip" {
  value = aws_instance.web_server.public_ip
}

output "db_server_public_ip" {
  value = aws_instance.db_server.public_ip
}
