provider "aws" {
  region = var.region
}

resource "aws_instance" "web" {
  ami                         = "ami-0c02fb55956c7d316"
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true

  tags = {
    Name        = "MyTerraformServer-${var.environment}"
    Environment = var.environment
  }
}
