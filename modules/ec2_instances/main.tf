resource "aws_instance" "app_server" {
  ami               = var.ami
  instance_type     = var.instance_type
  availability_zone = var.availability_zone

  tags = {
    Name = "App Server"
  }
}

# resource "aws_instance" "db_server" {
#   ami               = var.ami
#   instance_type     = var.instance_type
#   availability_zone = var.availability_zone
#   tags = {
#     Name = "DB Server"
#   }
# }
