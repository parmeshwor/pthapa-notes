resource "aws_instance" "pthapa-ec2-hello" {
  ami = var.ami
  instance_type = var.instance_type

  tags = {
    Name = "Some Name"
    Description = "Some Description"
  }

  # user_data = file("${path.module}/your_script.sh")

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello Aws EC2" > /tmp/hello.txt
              EOF

  key_name = aws_key_pair.pthapa-ec2-key.id
  vpc_security_group_ids = [aws_security_group.ssh-access.id]
}

resource "aws_key_pair" "pthapa-ec2-key" {
  key_name = "pthapa-ec2-key"
  public_key = file("~/.ssh/pthapa_aws_ec2.pub")
  
}

resource "aws_security_group" "ssh-access" {
  name = "ssh-access"
  description = "allow ssh from internet"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_ip" {
  value = aws_instance.pthapa-ec2-hello.public_ip
}