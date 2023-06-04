resource "aws_instance" "instance" {
  ami = data.aws_ami.centos_ami.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [data.aws_security_group.securitygrp.id]
  tags = {
    Name = var.env != "" ?  "${var.component_name}-${var.env}"  : var.component_name
  }
}
resource "null_resource" "provisioner" {

  depends_on = [aws_instance.instance, aws_route53_record.records]
  provisioner "remote-exec" {

    connection {
      type     = "ssh"
      user     = "centos"
      password = "DevOps321"
      host     = aws_instance.instance.private_ip
    }
    inline = [
      "rm -rf roboshop-shell",
      "git clone https://github.com/veena-kj/roboshop-shell",
      "cd roboshop-shell",
      "sudo bash ${var.component_name}.sh ${var.password} "
    ]
  }
}

resource "aws_route53_record" "records" {
  zone_id = "Z08406313PSKR2N4EROKD"
  name    = "${var.component_name}-dev.e-platform.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.instance.private_ip]
}
