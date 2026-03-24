# Hosted Zone
resource "aws_route53_zone" "main" {
  name = "myterraformapp.internal"

  tags = {
    Name        = "MyHostedZone"
    Environment = var.environment
  }
}

# CNAME Record pointing to ALB
resource "aws_route53_record" "alb" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "www.myterraformapp.internal"
  type    = "CNAME"
  ttl     = 300
  records = [aws_lb.main.dns_name]
}

# Health Check for ALB
resource "aws_route53_health_check" "alb" {
  fqdn              = aws_lb.main.dns_name
  port              = 80
  type              = "HTTP"
  resource_path     = "/"
  failure_threshold = 3
  request_interval  = 30

  tags = {
    Name        = "ALBHealthCheck"
    Environment = var.environment
  }
}

# Failover record — primary
resource "aws_route53_record" "primary" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "app.myterraformapp.internal"
  type    = "CNAME"
  ttl     = 60
  records = [aws_lb.main.dns_name]

  set_identifier = "primary"

  failover_routing_policy {
    type = "PRIMARY"
  }

  health_check_id = aws_route53_health_check.alb.id
}
