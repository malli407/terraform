### public-subnet web-server-01

resource "aws_instance" "public-subnet-01" {
  ami                         = var.ami_id
  count                       = 1
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public-01[0].id
  #associate_public_ip_address = "true"
  #user_data                   = file("shellscript.sh")
  key_name                     = "newkeypair"
  vpc_security_group_ids      = aws_security_group.my-sg.*.id
  root_block_device {
    volume_size           = var.volume_size
    delete_on_termination = true
  }
    tags = {
     # key = "Name"
     #value = "web_server01"
    Name = "${var.environment}-web_server01"
  } 
}

### private subnet mysql-server

resource "aws_instance" "private-mysql-servers" {
  ami                         = var.ami_id
  count                       = 2
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.private-01[count.index].id
  #associate_public_ip_address = "true"
  user_data                   = file("shellscript.sh")
  key_name                     = "newkeypair"
  vpc_security_group_ids      = aws_security_group.my-sg.*.id
  root_block_device {
    volume_size           = var.volume_size
    delete_on_termination = true
  }
    tags = {
     #name = var.mysql_servers[count.index]
     Name = "${var.environment}-${var.mysql_servers[count.index]}"
  }
  
}

### private subnet servers

resource "aws_instance" "private-subnet-01" {
  ami                         = var.ami_id
  count                       = var.instance_count
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.private-01[0].id
  #associate_public_ip_address = "true"
  #user_data                   = file("shellscript.sh")
  key_name                     = "newkeypair"
  vpc_security_group_ids      = aws_security_group.my-sg.*.id
  root_block_device {
    volume_size           = var.volume_size
    delete_on_termination = true
  }
    tags = {
     #name = var.server_names[count.index]
     Name = "${var.environment}-${var.server_names[count.index]}"
  }
  
}

/*resource "aws_instance" "private-mysql-slave" {
  ami                         = var.ami_id
  count                       = 1
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.private-01[1].id
  #associate_public_ip_address = "true"
  user_data                   = file("shellscript.sh")
  key_name                     = "newkeypair"
  vpc_security_group_ids      = aws_security_group.my-sg.*.id
  root_block_device {
    volume_size           = var.volume_size
    delete_on_termination = true
  }
    tags = {
     name = "mysql-slave"
  }
  
}*/

# to create extra volume 
/*resource "aws_ebs_volume" "root-volume" {
  availability_zone = "ap-south-1a"
  size              = 30
}

# to attach the created extra volume to instance
resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.root-volume.id
  instance_id = aws_instance.web-server01.id
}*/

resource "aws_security_group" "my-sg" {
  name        = "my-securitygroup"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name        = "my-securitygroup"
    Environment = "Dev"
  }
}