provider "aws" {
  region                  = "ap-south-1"
  profile                 = "default"
}
}

#-------------AWS_INSTANCE--------------------------
resource "aws_instance" "myOS" {
  ami           = "ami-0ad704c126371a549"
  instance_type = "t2.micro"
  key_name = "rhcsa"
 tags = {
    Name = "Os by face_recognition"  
  }
}

#------------AWS VOLUME------------------------
resource "aws_ebs_volume" "vol" {
  availability_zone = aws_instance.myOS.availability_zone
  size              = 1

  tags = {
    Name = "HD by face recognition"
  }
}

#---------------ATTACH VOLUME------------------
resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdc"
  volume_id   = aws_ebs_volume.vol.id (http://aws_ebs_volume.vol.id)
  instance_id = aws_instance.myOS.id (http://aws_instance.myOS.id)
}

resource "null_resource"  "nullremote" {
 connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("./rhcsa.pem")
    host     = aws_instance.myOS.public_ip
  }

provisioner "remote-exec" {
    inline = [
      "sudo mkfs.ext4 /dev/xvdc",
      "sudo  mount /dev/xvdc  /",
    ]
  }
}