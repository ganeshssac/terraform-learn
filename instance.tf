resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
 
}

resource "aws_instance" "nginxEC2" {

  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mykey.key_name
  tags = {
    Name = "EC2Nginx"
  }

 # increase the root volume from 8GB to 20yes
  root_block_device {
    volume_size = 20
    volume_type = "gp2"
    delete_on_termination = true
  }
 # role:
  iam_instance_profile = aws_iam_instance_profile.s3-mybucket-role-instanceprofile.name

   # the VPC subnet
  subnet_id = aws_subnet.main-public-1.id
  # assign security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  # upload script.sh file from local computer to EC2 remote host
  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }
  # Execute the script.sh using remote execution provisioner to spin up nginx server
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo sed -i -e 's/\r$//' /tmp/script.sh",
      "sudo /tmp/script.sh",
    ]
  }

  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }
}


  # add an additional EBS volume on top of root volume
  resource "aws_ebs_volume" "ebs-volume-1" {
  availability_zone = "eu-west-1a"
  size              = 20
  type              = "gp2"
  tags = {
    Name = "extra volume data"
  }
}

resource "aws_volume_attachment" "ebs-volume-1-attachment" {
  device_name = "/dev/xvdh"
  volume_id   = aws_ebs_volume.ebs-volume-1.id
  instance_id = aws_instance.nginxEC2.id
}

