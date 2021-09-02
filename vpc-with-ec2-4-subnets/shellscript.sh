#!/bin/bash
echo "Welcome to the server"
echo "---------------------"
echo date
sudo yum update -y
sudo yum install git -y 
sudo useradd malli
echo "welcome to the linux server"
sudo yum install mysql -y