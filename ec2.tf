# EC2 public1c
resource "aws_instance" "example-ec2-c" {
  ami                    = "ami-073770dc3242b2a06"  # AMI ID for the EC2 instance
  instance_type          = "t2.micro"  # Instance type for the EC2 instance
  subnet_id              = aws_subnet.example_public_1c.id  # Subnet ID where the EC2 instance will be launched
  vpc_security_group_ids = [aws_security_group.ec2_sg.id, aws_security_group.vpc_all_sg.id]  # Security groups associated with the EC2 instance
  key_name               = var.key_name  # SSH key pair for accessing the EC2 instance
  user_data              = file("install.sh")  # User data script for initial configuration of the EC2 instance

  tags = {
    Name = "example-ec2"  # Tags for identifying and labeling the EC2 instance
  }
}

# Key Pair
resource "aws_key_pair" "example-key-pair" {
  key_name   = var.key_name  # Name for the SSH key pair
  public_key = file("../${var.key_name}.pub")  # Path to the public key file
}

# SSH Elastic IP for EC2 public1c
resource "aws_eip" "example-ec2-eip-c" {
  instance = aws_instance.example-ec2-c.id  # ID of the EC2 instance to associate with the Elastic IP
  vpc      = true  # Specify if the Elastic IP is in a VPC
}

# EC2 public1d
resource "aws_instance" "example-ec2-d" {
  ami                    = "ami-073770dc3242b2a06"  # AMI ID for the EC2 instance
  instance_type          = "t2.micro"  # Instance type for the EC2 instance
  subnet_id              = aws_subnet.example_public_1d.id  # Subnet ID where the EC2 instance will be launched
  vpc_security_group_ids = [aws_security_group.ec2_sg.id, aws_security_group.vpc_all_sg.id]  # Security groups associated with the EC2 instance
  key_name               = var.key_name  # SSH key pair for accessing the EC2 instance
  user_data              = file("install.sh")  # User data script for initial configuration of the EC2 instance

  tags = {
    Name = "example-ec2"  # Tags for identifying and labeling the EC2 instance
  }
}

# SSH Elastic IP for EC2 public1d
resource "aws_eip" "example-ec2-eip-d" {
  instance = aws_instance.example-ec2-d.id  # ID of the EC2 instance to associate with the Elastic IP
  vpc      = true  # Specify if the Elastic IP is in a VPC
}
