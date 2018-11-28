resource "aws_security_group" "thumbor_redis_sg" {
  name        = "thumbor_redis_sg"
  description = "Allow inbound traffic for Thumbor service"

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["${aws_default_vpc.default_vpc.cidr_block}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(
    local.common_tags,
    map(
      "Name", "thumbor_sg"
    )
  )}"
}

resource "aws_elasticache_cluster" "thumbor_cache" {
  cluster_id           = "thumbor-cache"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis5.0"
  engine_version       = "5.0.0"
  port                 = 6379
  security_group_ids   = ["${aws_security_group.thumbor_redis_sg.id}"]
}