provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "K8-Master-Node-Utsav" {
  ami                    = "ami-06aa3f7caf3a30282"
  instance_type          = "t2.medium"
  key_name               = "devops-utsav-key"
  availability_zone      = "us-east-1a"
  vpc_security_group_ids = ["utsav-secgrp"]
  tags = {
    Name = "Utsav K8 Master"
  }
}

resource "aws_instance" "K8-Slave-Node-Utsav" {
  ami                    = "ami-06aa3f7caf3a30282"
  instance_type          = "t2.micro"
  key_name               = "devops-utsav-key"
  availability_zone      = "us-east-1a"
  vpc_security_group_ids = ["utsav-secgrp"]
  tags = {
    Name = "Utsav K8 Slave"
  }
}
