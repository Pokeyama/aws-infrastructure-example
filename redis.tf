# Elasticache Subnet Group Configuration
resource "aws_elasticache_subnet_group" "example-redis-group" {
  name       = "example-redis-group"
  subnet_ids = [aws_subnet.example_private_1a.id, aws_subnet.example_private_1b.id]
}

# Elasticache Replication Group Configuration
resource "aws_elasticache_replication_group" "example-redis" {
  replication_group_id       = "example-redis"
  description                = "example redis"
  node_type                  = "cache.t3.micro"
  automatic_failover_enabled = true
  num_cache_clusters         = 2
  engine_version             = "6.x"
  subnet_group_name          = aws_elasticache_subnet_group.example-redis-group.name
  port                       = 6379
  security_group_ids         = [aws_security_group.redis_sg.id]
  #  parameter_group_name          = "default.redis5.0"
  tags                       = {
    Name = "example-redis"
  }
}
