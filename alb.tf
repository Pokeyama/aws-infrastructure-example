# ALB (Application Load Balancer)
resource "aws_lb" "example_alb" {
  load_balancer_type = "application"
  name               = "example-alb"
  internal           = false

  security_groups = [aws_security_group.alb_sg.id]
  subnets         = [aws_subnet.example_public_1a.id, aws_subnet.example_public_1b.id]

  tags = {
    Name = "hello"  # Tag: "hello" to identify the ALB
  }
}

# ALB Listener Configuration
resource "aws_lb_listener" "example_alb_listener" {
  port              = "80"
  protocol          = "HTTP"
  load_balancer_arn = aws_lb.example_alb.arn

  # Redirect to HTTPS when accessed via HTTP
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.example_alb_target_group.arn
  }
  tags = {
    Name = "example-alb-listener"  # Tag: "example-alb-listener" to identify the ALB listener
  }
}

# ALB Listener for HTTPS
resource "aws_alb_listener" "https_test" {
  load_balancer_arn = aws_lb.example_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  # Attach the SSL certificate
  certificate_arn   = aws_acm_certificate.example_cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.example_alb_target_group.arn
  }
}

# ALB Target Group
resource "aws_lb_target_group" "example_alb_target_group" {
  name             = "example-lb-tg"
  port             = 80
  protocol         = "HTTP"
  protocol_version = "HTTP1"
  vpc_id           = aws_vpc.example_vpc.id
  target_type      = "instance"

  health_check {
    path = "/"
  }
}

# Connect ALB with EC2 1c
resource "aws_lb_target_group_attachment" "example_alb_a" {
  target_group_arn = aws_lb_target_group.example_alb_target_group.arn
  target_id        = aws_instance.example-ec2-c.id
  port             = 8080
}

# Connect ALB with EC2 1d
resource "aws_lb_target_group_attachment" "example_alb_b" {
  target_group_arn = aws_lb_target_group.example_alb_target_group.arn
  target_id        = aws_instance.example-ec2-d.id
  port             = 8080
}
