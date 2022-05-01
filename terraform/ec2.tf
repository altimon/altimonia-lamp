#Create key_pair
resource "aws_key_pair" "altimonia_id_rsa" {
  key_name   = "altimonia_id_rsa"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDFY8vnlWfPDg4nK2ZKBEBOfeGVBGOS2ScYUR9bBB/1o7bKzzgyS7TxeBAcJEh8A4aE6qyHHTF8a1jh2tPF6wMiXi5bcU0dAA/RCrDgwCN3IbJy3BN3YgTTzSyaMoOAd2wsfV+jwFQnMrK592PIc9Q44W/7KDzLweDB4nJxDLfEGXdDA7c2SOHAC5C38vz9Mlsd8kMe51W6Sl4MwWlWaZ1Qh/d1ADCaQ8DFF0VSCw/PN9KeFcRkTv45WnzT4c5V1i0xuO3VjbFsGYtPkfIMBbU/Yt/ZCHVkFMhKuTOchp+z6ZJFHDFKYu5BFKi0Gkcn/l1kOrmGbzj301qASqho4tylYhkwjXGNmF6o07wK4aU3MQpCsCI18mn/giAitfEZLoEr/BxzfBW9IMiL6dp/GmgLhbO65TKGACym6RuQCdCxTXpr4egPykKcMvOxacS6NOuM29Nkp5E0K7O6zinris8heJyt8ZJ/MX51rp2TOYc+GELFyq3Cl7k36mz4y7Bz9aM= altimon@Dnepr-2.local"
}

#create EC2 instance
resource "aws_instance" "altimonia_web_instance" {
  ami                    = lookup(var.images, var.region)
  instance_type          = "t2.micro"
  key_name               = "altimonia_id_rsa" #make sure you have your_private_key.pem file
  vpc_security_group_ids = [aws_security_group.web_security_group.id]
  subnet_id              = aws_subnet.altimonia_vpc_public_subnet.id
  tags = {
    Name = "altimonia_web_instance"
  }
  volume_tags = {
    Name = "altimonia_web_instance_volume"
  }
  provisioner "remote-exec" { #install apache, mysql client, php
    inline = [
      "sudo mkdir -p /var/www/html/",
      "sudo yum update -y",
      "sudo yum install -y httpd",
      "sudo service httpd start",
      "sudo usermod -a -G apache ec2-user",
      "sudo chown -R ec2-user:apache /var/www",
      "sudo yum install -y mysql php php-mysql"
    ]
  }
  provisioner "file" { #copy the index file from local to remote
    source      = "index.php"
    destination = "/var/www/html/index.php"
  }
  connection {
    host     = self.public_ip
    type     = "ssh"
    user     = "ec2-user"
    password = ""
    #TODO copy <your_private_key>.pem to your local instance home directory
    #TODO restrict permission: chmod 400 <your_private_key>.pem
    private_key = file("../secrets/altimonia_id_rsa")
  }
}
