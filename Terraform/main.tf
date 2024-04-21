provider "aws" {
  region = var.aws_region
}

resource "aws_iam_role" "ec2_admin_role" {
  name = "ec2-admin-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "ec2_admin_attachment" {
  name       = "ec2-admin-attachment"
  roles      = [aws_iam_role.ec2_admin_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "tls_private_key" "rsa-4096-example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "pin" {
  key_name   = var.key_pair_name
  public_key = file("~/.ssh/id_rsa.pub")
}



resource "aws_instance" "PIN_final" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  subnet_id = "subnet-0a7131bf0e69a8b87"
  key_name               = aws_key_pair.pin.key_name
  vpc_security_group_ids = [aws_security_group.sg_ssh.id, aws_security_group.sg_web.id]
  user_data              = file("ec2_user_data.sh")
  associate_public_ip_address = true  
  tags = {
    Name = "pin-final"
  }
}
resource "aws_security_group" "sg_ssh" {
  name = "sg_ssh"
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  // connectivity to ubuntu mirrors is required to run `apt-get update` and `apt-get install apache2`
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sg_web" {
  name        = "sg_web"
  description = "allow 8080"
}

resource "aws_security_group_rule" "sg_web" {
  type      = "ingress"
  to_port   = "8080"
  from_port = "8080"
  protocol  = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_web.id
}

