data "aws_ami" "centos_ami"{
  owners = ["973714476881"]
  most_recent = true
  name_regex = "Centos-8-DevOps-Practice"
}
data "aws_security_group" "securitygrp"{
  name="allow-all"
}
#resource "aws_instance" "frontend" {
#  ami           = data.aws_ami.centos_ami.image_id
#  instance_type = "t3.micro"
#    tags = {
#    Name = "frontend"
#  }
#}

variable "components" {
  default = {
    frontend={
      name = "frontend"
      instance_type = "t3.micro"
    }
    mongodb ={
      name = "mongodb"
      instance_type ="t3.small"
    }
    catalogue={
      name = "catalogue"
      instance_type = "t3.micro"
    }
    mysql={
      name = "mysql"
      instance_type = "t3.micro"
    }
    user={
      name = "user"
      instance_type = "t3.micro"
    }
    cart={
      name = "cat"
      instance_type = "t3.micro"
          }
    redis={
      name = "redis"
      instance_type = "t3.micro"
    }
    rabbitmq={
      name = "rabbitmq"
      instance_type = "t3.micro"
    }
    payment={
      name = "payment"
      instance_type = "t3.micro"
    }
    shipping={
      name = "shipping"
      instance_type = "t3.micro"
    }
    dispatch={
      name = "dispatch"
      instance_type = "t3.micro"
    }
  }
}

resource "aws_instance" "instance" {
  for_each = var.components
  ami = data.aws_ami.centos_ami.image_id
  instance_type = each.value["instance_type"]
  vpc_security_group_ids = [data.aws_security_group.securitygrp.id]
  tags = {
    Name = each.value["name"]
  }
}

resource "aws_route53_record" "records" {

  for_each = var.components

  zone_id = "Z08406313PSKR2N4EROKD"
  name    = "${each.value["name"]}-dev.e-platform.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.instance[each.value["name"]].private_ip]
}
#
#resource "aws_instance" "mongodb" {
#  ami           = data.aws_ami.centos_ami.image_id
#  instance_type = var.instance_type
#  tags = {
#    Name = "mongodb"
#  }
#}
#
#resource "aws_route53_record" "mongodb" {
#  zone_id = "Z08406313PSKR2N4EROKD"
#  name    = "mongod.e-platform.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.mongodb.private_ip]
#}
#
#resource "aws_instance" "catalogue" {
#  ami           = data.aws_ami.centos_ami.image_id
#  instance_type = "t3.micro"
#  tags = {
#    Name = "catalogue"
#  }
#}
#
#resource "aws_route53_record" "catalogue" {
#  zone_id = "Z08406313PSKR2N4EROKD"
#  name    = "catalogued.e-platform.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.catalogue.private_ip]
#}
#
#resource "aws_instance" "mysql" {
#  ami=data.aws_ami.centos_ami.image_id
#  instance_type = "t3.micro"
#  tags = {
#    Name="mysql"
#  }
#}
#resource "aws_route53_record" "mysql" {
#  zone_id = "${var.zone_id}"
#  name= "mysqld.e-platform.online"
#  type = "A"
#  ttl =30
#  records = [aws_instance.mysql.private_ip]
#}
#resource "aws_instance" "user" {
#  ami           = data.aws_ami.centos_ami.image_id
#  instance_type = "t3.micro"
#  tags = {
#    Name = "user"
#  }
#}
#
#resource "aws_route53_record" "user" {
#  zone_id = "Z08406313PSKR2N4EROKD"
#  name    = "userd.e-platform.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.user.private_ip]
#}
#resource "aws_instance" "cart" {
#  ami           = data.aws_ami.centos_ami.image_id
#  instance_type = "t3.micro"
#  tags = {
#    Name = "cart"
#  }
#}
#
#resource "aws_route53_record" "cart" {
#  zone_id = "Z08406313PSKR2N4EROKD"
#  name    = "cartd.e-platform.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.cart.private_ip]
#}
#resource "aws_instance" "redis" {
#  ami           = data.aws_ami.centos_ami.image_id
#  instance_type = "t3.micro"
#  tags = {
#    Name = "redis"
#  }
#}
#
#resource "aws_route53_record" "redis" {
#  zone_id = "Z08406313PSKR2N4EROKD"
#  name    = "redisd.e-platform.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.redis.private_ip]
#}
#resource "aws_instance" "rabbitmq" {
#  ami           = data.aws_ami.centos_ami.image_id
#  instance_type = "t3.micro"
#  tags = {
#    Name = "rabbitmq"
#  }
#}
#
#resource "aws_route53_record" "rabbitmq" {
#  zone_id = "Z08406313PSKR2N4EROKD"
#  name    = "rabbitmqd.e-platform.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.rabbitmq.private_ip]
#}
#resource "aws_instance" "payment" {
#  ami           = data.aws_ami.centos_ami.image_id
#  instance_type = "t3.micro"
#  tags = {
#    Name = "payment"
#  }
#}
#
#resource "aws_route53_record" "payment" {
#  zone_id = "Z08406313PSKR2N4EROKD"
#  name    = "paymentd.e-platform.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.payment.private_ip]
#}
#resource "aws_instance" "shipping" {
#  ami           = data.aws_ami.centos_ami.image_id
#  instance_type = "t3.micro"
#  tags = {
#    Name = "shipping"
#  }
#}
#
#resource "aws_route53_record" "shipping" {
#  zone_id = "Z08406313PSKR2N4EROKD"
#  name    = "shippingd.e-platform.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.shipping.private_ip]
#}
#resource "aws_instance" "dispatch" {
#  ami           = data.aws_ami.centos_ami.image_id
#  instance_type = "t3.micro"
#  tags = {
#    Name = "dispatch"
#  }
#}
#
#resource "aws_route53_record" "dispatch" {
#  zone_id = "Z08406313PSKR2N4EROKD"
#  name    = "dispatchd.e-platform.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.dispatch.private_ip]
#}