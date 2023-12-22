# Ec2 public network
resource "aws_instance" "my_ec2" {
  ami = data.aws_ami.my_ami
  instance_type = var.type_instance
  subnet_id = var.my_public_subnet
  vpc_security_group_ids = [var.my_sg]
  #difinir une cle ssh
  key_name = var.secure_key_name
  #installer via script shell
  user_data = var.file-path
  #connection distant
  connection {
    type = "ssh"
    host = aws_instance.my_ec2.private_ip
    user = "ubuntu"
    host_key = file(var.pub-key-path)
    private_key = file(var.priv-key-path)
  }
  #commande distant
  provisioner "remote-exec" {
    inline =  var.remoteCommande

  }
  #eBS stockage
  ebs_block_device {
     device_name = "/dev/sda1"
     encrypted = true
     volume_size = var.ebs_size
     delete_on_termination = true
  }

  tags = {
    Name = "Ec2${var.Ec2Module}"
  }
}
resource "aws_eip_association" "eip_assoc" {
   instance_id   = aws_instance.my_ec2.id
  allocation_id = var.eip_ec2
  }


