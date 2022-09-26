variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "172.16.0.0/16"
}

variable "internal_cidr_block" {
  description = "CIDR block for the internal network"
  type        = string
  default     = "172.16.0.0/24"
}

variable "db_cidr_block" {
  description = "CIDR block for the database network"
  type        = string
  default     = "172.16.1.0/24"
}

variable "web_cidr_block" {
  description = "CIDR block for the web network"
  type        = string
  default     = "172.16.2.0/24"
}

variable "nat_cidr_block" {
  description = "CIDR block for the NAT network"
  type        = string
  default     = "172.16.3.0/24"
}

variable "availability_zone" {
  description = "AWS availability zone"
  type        = string
}

variable "ami" {
  description = "AMI ID"
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
  description = "Admin user for WordPress"
  type        = string
}

variable "admin_pass" {
  description = "Admin password for WordPress"
  type        = string
}

variable "iam_s3_access_key" {
  description = "IAM access key for S3"
  type        = string
}

variable "iam_s3_secret_key" {
  description = "IAM secret key for S3"
  type        = string
}

variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
}

variable "bucket_region" {
  description = "S3 bucket region"
  type        = string
}
