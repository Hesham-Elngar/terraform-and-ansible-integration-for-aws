terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-west-1"
}

# Get latest Amazon Linux 2023 AMI
data "aws_ssm_parameter" "ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_instance" "Ansible-Controller" {
  ami           = data.aws_ssm_parameter.ami.value
  instance_type = "t2.micro"
  key_name      = var.key_name
  vpc_security_group_ids = var.security_group

  user_data = <<-EOF
    #!/bin/bash
    dnf update -y
    dnf install -y python3 python3-pip git
    pip3 install ansible
    echo "Ansible installed successfully" > /home/ec2-user/ansible_ready.txt
  EOF

  tags = {
    Name        = "Ansible-Controller"
    Environment = "prod"
    Role        = "master"
  }
}

resource "aws_instance" "Ansible-Node" {
  ami           = data.aws_ssm_parameter.ami.value
  instance_type = "t2.micro"
  vpc_security_group_ids = var.security_group
  count         = 5
  key_name      = var.key_name

  tags = {
    Name        = "Ansible-Node-${count.index}"
    Environment = "prod"
    Role        = "slave"
  }
}


