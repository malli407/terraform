
provider "aws" {
  region = var.region
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"

  tags = {
    Name = "${var.environment}-vpc"
  }
}

/*resource "aws_subnet" "public-01" {
  #name                    = var.public_subnet_names
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "my-public-01"
  }
}


resource "aws_subnet" "public-02" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "my-public-02"
  }
}*/

resource "aws_subnet" "public-01" {
  vpc_id                  = aws_vpc.main.id
  count = length(var.public_cidr)
  availability_zone = element(var.availability_zones,count.index)
  cidr_block = element(var.public_cidr,count.index)
  map_public_ip_on_launch = "true"

  tags = {
    Name = element(var.public_subnet_names,count.index)
  }
}


/*resource "aws_subnet" "private-01" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "my-private-01"
  }
}

resource "aws_subnet" "private-02" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "my-private-02"
  }
}*/

resource "aws_subnet" "private-01" {
  vpc_id                  = aws_vpc.main.id
  count = length(var.private_cidr)
  availability_zone = element(var.availability_zones,count.index)
  cidr_block = element(var.private_cidr,count.index)
  

  tags = {
    Name = element(var.private_subnet_names,count.index)
  }
}



resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "my-igw"
  }
}

resource "aws_eip" "my-eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.my-eip.id
  subnet_id     = aws_subnet.public-01[0].id

  tags = {
    Name = "my-nat"
  }
}

resource "aws_route_table" "public-route-01" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }
  tags = {
    Name = "public-route-01"
  }
}

/*resource "aws_route_table" "public-route-02" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }
  tags = {
    Name = "public-route-02"
  }
}*/


resource "aws_route_table" "private-route-01" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gw.id
  }
  tags = {
    Name = "private-route-01"
  }
}

/*resource "aws_route_table" "private-route-02" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gw.id
  }
  tags = {
    Name = "private-route-02"
  }
}*/

/*resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public-01.id
  route_table_id = aws_route_table.public-route-01.id

}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.public-02.id
  route_table_id = aws_route_table.public-route-02.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.private-01.id
  route_table_id = aws_route_table.private-route-01.id
}

resource "aws_route_table_association" "d"{
  subnet_id      = aws_subnet.private-02.id
  route_table_id = aws_route_table.private-route-02.id
} */

resource "aws_route_table_association" "a" {
count = length(var.public_cidr)
  subnet_id      = element(aws_subnet.public-01.*.id,count.index)
  route_table_id = aws_route_table.public-route-01.id
}

resource "aws_route_table_association" "d" {
count = length(var.private_cidr)
  subnet_id      = element(aws_subnet.private-01.*.id,count.index)
  route_table_id = aws_route_table.private-route-01.id
}


data "aws_availability_zones" "available"{
  state = "available"
}

data "aws_caller_identity" "current" {}