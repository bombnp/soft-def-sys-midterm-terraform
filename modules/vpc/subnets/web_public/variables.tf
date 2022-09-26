variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the subnet"
  type        = string
}

variable "availability_zone" {
  description = "AWS availability zone"
  type        = string
}

variable "igw_id" {
  description = "Internet gateway ID"
  type        = string
}

variable "internal_eni_id" {
  description = "Internal ENI ID"
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

variable "database_host" {
  description = "Private IP address of the database server"
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
