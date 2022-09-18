variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "172.16.0.0/16"
}

variable "availability_zone" {
  description = "AWS availability zone"
  type        = string
}
