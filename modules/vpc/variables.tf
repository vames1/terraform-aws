variable "cidr_block" {
  description = "CIDR block for the VPC"
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet"
}

variable "vpc_name" {
  description = "Name of the VPC"
}

variable "availability_zone" {
  description = "Availability zone for the subnet"
  default     = "us-east-1a"
}
