# RDS Subnet Group
resource "aws_db_subnet_group" "private-db" {
  name       = "private-db"
  subnet_ids = [aws_subnet.example_private_1a.id, aws_subnet.example_private_1b.id]
  tags       = {
    Name = "private-db"  # Tag: "private-db" for identifying the DB subnet group
  }
}

# RDS Parameter Group
resource "aws_db_parameter_group" "rds_parameter_group" {
  name   = "example-db-parameter"  # Parameter group name
  family = "mariadb10.6"

  # Database parameters to be set
  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }
  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }
}

# RDS Database Instance
resource "aws_db_instance" "example-db" {
  identifier                = "example-db"  # Database instance identifier
  allocated_storage         = 20
  backup_retention_period   = 0
  storage_type              = "gp2"
  engine                    = "mariadb"
  engine_version            = "10.6.7"
  instance_class            = "db.t3.micro"
  username                  = "root"
  password                  = var.rds_password
  vpc_security_group_ids    = [aws_security_group.rds_sg.id]
  db_subnet_group_name      = aws_db_subnet_group.private-db.name
  parameter_group_name      = aws_db_parameter_group.rds_parameter_group.name
  skip_final_snapshot       = false
  final_snapshot_identifier = "example-db"  # Final snapshot identifier

  tags = {
    Name = "example-db"  # Tag: "example-db" for identifying the DB instance
  }
}
