# DB Subnet Group
resource "aws_db_subnet_group" "main" {
  name       = "my-db-subnet-group"
  subnet_ids = [aws_subnet.public.id, aws_subnet.public_b.id]

  tags = {
    Name        = "MyDBSubnetGroup"
    Environment = var.environment
  }
}

# Security Group for RDS
resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Allow MySQL traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "RDSSecurityGroup"
    Environment = var.environment
  }
}

# RDS Instance
resource "aws_db_instance" "mysql" {
  identifier           = "my-terraform-db"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  allocated_storage    = 20
  storage_type         = "gp2"
  db_name              = "myappdb"
  username             = var.db_username
  password             = var.db_password
  skip_final_snapshot  = true
  publicly_accessible  = false
  multi_az             = false
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name

  tags = {
    Name        = "MyTerraformDB"
    Environment = var.environment
  }
}

# Output RDS endpoint
output "rds_endpoint" {
  value = aws_db_instance.mysql.endpoint
}
