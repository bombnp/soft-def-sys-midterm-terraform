variable "availability_zone" {
  description = "AWS availability zone"
  type        = string
  default     = "us-west-2ax"
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
