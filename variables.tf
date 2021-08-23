variable "region" {
  type        = string
  default     = "ap-south-1"
  description = "Region details"
}

variable "vpc_cidr" {
  type    = string
  default = "192.16.0.0/16"
}

variable "public_cidr" {
  type    = string
  default = "192.16.1.0/24"
}

variable "private_cidr" {
  type    = string
  default = "192.16.3.0/24"
}

variable "availability_zones" {
  type    = list(any)
  default = ["ap-south-1a", "ap-south-1b"]
}


variable "public_subnet_name" {
  type    = string
  default = "malli-public-01"
}

variable "private_subnet_name" {
  type    = string
  default = "malli-private-01"
}

variable "ami_id" {
  type    = string
  default = "ami-00bf4ae5a7909786c"
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "environment" {
  type    = string
  default = "Dev"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "volume_size" {
  type    = number
  default = 10
}

variable "key_name" {
  type    = string
  default = "malli"
}



