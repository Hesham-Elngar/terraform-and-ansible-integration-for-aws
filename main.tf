terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

data "aws_subnet" "my_Subnet" {
  id = var.subnet_id
}

data "aws_vpc" "default" {
  id = var.vpc_id   
}

# Get latest Amazon Linux 2023 AMI
data "aws_ssm_parameter" "ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_iam_role" "ansible_controller_role" {
  name = "ansible-controller-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ansible_controller_policy_attach" {
  role       = aws_iam_role.ansible_controller_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}


resource "aws_iam_instance_profile" "ansible_controller_profile" {
  name = "ansible-controller-profile"
  role = aws_iam_role.ansible_controller_role.name
}

resource "aws_instance" "Ansible-Controller" {
  ami           = data.aws_ssm_parameter.ami.value
  instance_type = "t2.micro"
  key_name      = var.key_name
  vpc_security_group_ids = var.security_group
  subnet_id         = var.subnet_id

  iam_instance_profile = aws_iam_instance_profile.ansible_controller_profile.name

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
  subnet_id         = var.subnet_id

  tags = {
    Name        = "Ansible-Node-${count.index}"
    Environment = "prod"
    Role        = "slave"
  }
}