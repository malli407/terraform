variable "region" {
    type = string
    default = "ap-south-1"
    description ="Region details"
}

variable "vpc_cidr" {
     type = string 
     default = "10.0.0.0/16"
}

variable "public_cidr" {
    type = list
    default = ["10.0.1.0/24","10.0.2.0/24"]
}

variable "private_cidr" {
    type = list
    default = ["10.0.3.0/24","10.0.4.0/24"]
}

variable "availability_zones" {
    type = list
    default = ["ap-south-1a","ap-south-1b"]
}


variable "public_subnet_names" {
    type = list
    default = ["public-01","public-02"]
}

variable "private_subnet_names" {
    type = list
    default = ["private-01","private-02"]
}

variable "ami_id"{
    type = string
    default = "ami-00bf4ae5a7909786c"
}

variable "instance_count"{
    type = number
    default = 4 
}

variable "mysql_servers" {
    type = list
    default = ["mysql-master","mysql-slave"]
}

variable "server_names" {
    type = list(string)
    default = ["app-server","job-server","minio1","js-ws"]
}

variable "environment" {
    type = string
    default = "Dev"
}
 
variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "volume_size" {
    type = number
    default = 20
}

variable "key_name" {
    type = string
    default = "newkeypair"
}

/*variable "public_key" {
    type = string
    default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCMCo90IjlKRS6fl++4jYGqz7GLoi+lePNEFO1R4sR4BKw1wox8oAC+jFJN7Bze6Xoq80cbo1EhyBwwMGmX7cDr9GmhL9OCTzUgx9NOCjcJNEvZmeyerLhoaksrerwg9ouvJq3djMDuwDf5Nl3oEJUPoiYPj9nl0apnq2Lu2Dmjs3rpuHQEbv1QwhX4jyGo164od85gLY7TaejxAunosXstCWDN9n9rpEJ8+ywxjm5VYtA0DHEO7PsRDmiacb+PSi51ESI0Ns06KL3NTSK21lfjDCwvQRwGfalKggeoUdVOOLs80f0KB8F97tepYq4uEmSstQs0PZL0IJlNQ8OB2lL1 imported-openssh-key"
}*/




