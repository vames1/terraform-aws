# EC2 Instance 1
resource "aws_instance" "ansible_ec2_1" {
  ami                         = "ami-0c02fb55956c7d316"
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true
  key_name                    = "EC2-keypair"

  tags = {
    Name        = "AnsibleServer1"
    Environment = var.environment
  }
}

# EC2 Instance 2
resource "aws_instance" "ansible_ec2_2" {
  ami                         = "ami-0c02fb55956c7d316"
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true
  key_name                    = "EC2-keypair"

  tags = {
    Name        = "AnsibleServer2"
    Environment = var.environment
  }
}

# Output the public IPs
output "ansible_ec2_1_ip" {
  value = aws_instance.ansible_ec2_1.public_ip
}

output "ansible_ec2_2_ip" {
  value = aws_instance.ansible_ec2_2.public_ip
}
