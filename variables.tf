variable "region" {
  description = "AWS region"
  type        = string
}

variable "availability_zone" {
  description = "AWS availability zone"
  type        = string
}

variable "ami" {
  description = "AMI ID"
  type        = string
}

variable "bucket_name" {
  description = "Name of the S3 bucket for this project"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "database_name" {
  description = "Name of the database"
  type        = string
}

variable "database_user" {
  description = "Name of the database user"
  type        = string
}

variable "database_pass" {
  description = "Password for the database user"
  type        = string
}

variable "admin_user" {
  description = "Name of the admin user"
  type        = string
}

variable "admin_pass" {
  description = "Password for the admin user"
  type        = string
}
