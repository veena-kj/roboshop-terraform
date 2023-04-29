resource "aws_instance" "frontend" {
  ami           = "ami-0b5a2b5b8f2be4ec2"
  instance_type = "t3.micro"
    tags = {
    Name = "frontend"
  }
}
output "frontend" {
  value=aws_instance.frontend.public_ip
}

data "aws_ami" "centos_ami"{
  owner = 973714476881
  name_regex = "Centos-8-DevOps-Practice"
  }
output "ami_details" {
  value = data.aws_ami.centos_ami.image_id
}