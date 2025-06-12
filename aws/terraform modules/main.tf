resource "aws_instance" "apache_machine" {
  instance_type          = "t3.micro"
  ami                    = data.aws_ami.ec_machine.id
  user_data              = file("scripts/userdata.sh") # <--- ADD THIS LINE with the name of your new user data
  vpc_security_group_ids = [aws_security_group.sg_name.id]
  key_name               = "terraform" # <--- ADD THIS LINE with the name of your new key pair


  tags = {
    Env = "Development"
  }
}

output "public_ip" {
  value = aws_instance.apache_machine.public_ip
}

data "aws_ami" "ec_machine" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }

}

resource "aws_security_group" "sg_name" {
  name        = "allow_http"
  description = "Allow http inbound traffic"
  vpc_id      = "vpc-0aca8b3bd9d814704"

  ingress { # This defines an ingress block within a list
    description = "allow HTTP"
    from_port   = 80 # Port numbers should be integers, not strings
    to_port     = 80 # Port numbers should be integers, not strings
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress { # This defines an ingress block within a list
    description = "allow HTTPS"
    from_port   = 443 # Port numbers should be integers, not strings
    to_port     = 443 # Port numbers should be integers, not strings
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress { # This defines an egress block within a list
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Env = "Development"
  }
}