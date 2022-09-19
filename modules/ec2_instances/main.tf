# resource "aws_instance" "app_server" {
#   ami               = var.ami
#   instance_type     = var.instance_type
#   availability_zone = var.availability_zone

#   tags = {
#     Name = "App Server"
#   }
# }

resource "aws_instance" "db_server" {
  ami               = var.ami
  instance_type     = var.instance_type
  availability_zone = var.availability_zone

  # TODO: remove this, default vpc
  security_groups = ["launch-wizard-6"]
  user_data       = file("init-db.sh")

  tags = {
    Name = "DB Server"
  }
}

output "db_server_public_ip" {
  value = aws_instance.db_server.public_ip
}
