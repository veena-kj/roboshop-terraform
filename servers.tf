resource "aws_instance" "frontend" {
  ami           = data.aws_ami.centos_ami.image_id
  instance_type = "t3.micro"
    tags = {
    Name = "frontend"
  }
}

data "aws_ami" "centos_ami"{
  owners = ["973714476881"]
  name_regex = "Centos-8-DevOps-Practice"
}
output "ami_details" {
  value = data.aws_ami.centos_ami.image_id
}
output "frontend" {
  value=aws_instance.frontend.public_ip
  }
output "frontendIP" {
  value=aws_instance.frontend.private_ip
}

resource "aws_instance" "mongodb" {
  ami           = data.aws_ami.centos_ami.image_id
  instance_type = "t3.micro"
  tags = {
    Name = "mongodb"
  }
}

resource "aws_instance" "catalogue" {
  ami           = data.aws_ami.centos_ami.image_id
  instance_type = "t3.micro"
  tags = {
    Name = "catalogue"
  }
}