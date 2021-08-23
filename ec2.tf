### public-subnet web-server-01

resource "aws_instance" "public-subnet-01" {
  ami           = var.ami_id
  count         = var.instance_count
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public-01.id
  #user_data                   = file("shellscript.sh")
  key_name               = var.key_name
  vpc_security_group_ids = aws_security_group.my-sg.*.id
  root_block_device {
    volume_size           = var.volume_size
    delete_on_termination = true
  }
  tags = {
    Name = "malli_server01"
  }
}

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
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #for tomcat port changed  8080 to 8090 
  ingress {
    description = "TLS from VPC"
    from_port   = 8090
    to_port     = 8090
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
    Name        = "malli-securitygroup"
    Environment = "Dev"
  }
}