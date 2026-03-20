# Application Load Balancer
resource "aws_lb" "main" {
  name               = "my-terraform-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_sg.id]
  subnets            = [aws_subnet.public.id, aws_subnet.public_b.id]

  tags = {
    Name        = "MyALB"
    Environment = var.environment
  }
}

# Target Group — where ALB sends traffic
resource "aws_lb_target_group" "web" {
  name        = "my-web-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
  }

  tags = {
    Name        = "MyWebTargetGroup"
    Environment = var.environment
  }
}

# Listener — listens for incoming traffic on port 80
resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}
