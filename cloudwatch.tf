# CloudWatch Log Group for ECS
resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = "/ecs/my-web-app"
  retention_in_days = 7

  tags = {
    Name        = "ECSLogGroup"
    Environment = var.environment
  }
}

# CloudWatch Dashboard
resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "my-terraform-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric"
        properties = {
          title  = "ECS CPU Utilization"
          period = 300
          stat   = "Average"
          region = "us-east-1"
          metrics = [
            ["AWS/ECS", "CPUUtilization",
              "ClusterName", "my-terraform-cluster",
              "ServiceName", "my-web-service"
            ]
          ]
        }
      },
      {
        type = "metric"
        properties = {
          title  = "ECS Memory Utilization"
          period = 300
          stat   = "Average"
          region = "us-east-1"
          metrics = [
            ["AWS/ECS", "MemoryUtilization",
              "ClusterName", "my-terraform-cluster",
              "ServiceName", "my-web-service"
            ]
          ]
        }
      },
      {
        type = "metric"
        properties = {
          title  = "ALB Request Count"
          period = 300
          stat   = "Sum"
          region = "us-east-1"
          metrics = [
            ["AWS/ApplicationELB", "RequestCount",
              "LoadBalancer", aws_lb.main.arn_suffix
            ]
          ]
        }
      }
    ]
  })
}
         

# SNS Topic for alerts
resource "aws_sns_topic" "alerts" {
  name = "my-cloudwatch-alerts"

  tags = {
    Name        = "CloudWatchAlerts"
    Environment = var.environment
  }
}

# SNS Email Subscription
resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

# CloudWatch Alarm — High CPU with SNS notification
resource "aws_cloudwatch_metric_alarm" "high_cpu_alert" {
  alarm_name          = "high-cpu-alert"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Alert when CPU exceeds 80%"
  alarm_actions       = [aws_sns_topic.alerts.arn]
  ok_actions          = [aws_sns_topic.alerts.arn]

  dimensions = {
    ClusterName = aws_ecs_cluster.main.name
    ServiceName = aws_ecs_service.web.name
  }

  tags = {
    Name        = "HighCPUAlert"
    Environment = var.environment
  }
}

# CloudWatch Alarm — ALB 5XX errors
resource "aws_cloudwatch_metric_alarm" "alb_errors" {
  alarm_name          = "alb-5xx-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "HTTPCode_ELB_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  alarm_description   = "Alert when ALB returns too many 5XX errors"
  alarm_actions       = [aws_sns_topic.alerts.arn]

  dimensions = {
    LoadBalancer = aws_lb.main.arn_suffix
  }

  tags = {
    Name        = "ALB5XXErrors"
    Environment = var.environment
  }
}
