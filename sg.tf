# ALB Security Group
resource "aws_security_group" "alb_sg" {
  name        = "example-alb-sg"
  description = "example alb sg"
  vpc_id      = aws_vpc.example_vpc.id

  # Allow incoming HTTP traffic from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow incoming HTTPS traffic from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rule allowing all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# VPC Internal Security Group
resource "aws_security_group" "vpc_all_sg" {
  name        = "example-vpc-all"
  description = "example vpc-all sg"
  vpc_id      = aws_vpc.example_vpc.id

  # Allow all incoming and outgoing traffic within the VPC
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = [aws_vpc.example_vpc.cidr_block]
  }

  # Outbound rule allowing all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Security Group
resource "aws_security_group" "ec2_sg" {
  name        = "example-ec2"
  description = "example ec2 sg"
  vpc_id      = aws_vpc.example_vpc.id

  # Allow incoming SSH traffic from anywhere (for demonstration purposes)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rule allowing all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# RDS Security Group
resource "aws_security_group" "rds_sg" {
  name        = "example-rds"
  description = "example rds sg"
  vpc_id      = aws_vpc.example_vpc.id

  # Allow incoming MySQL traffic from EC2 instances
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
  }

  # Outbound rule allowing all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Redis Security Group
resource "aws_security_group" "redis_sg" {
  name        = "example-redis"
  description = "example redis sg"
  vpc_id      = aws_vpc.example_vpc.id

  # Allow all incoming and outgoing traffic on port 6379 (for demonstration purposes)
  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rule allowing all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
