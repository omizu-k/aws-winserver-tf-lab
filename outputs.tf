output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "public_subnet_1_id" {
  description = "パブリックサブネット1 ID（ALB用 / AZ-a）"
  value       = aws_subnet.public_1.id
}

output "public_subnet_2_id" {
  description = "パブリックサブネット2 ID（ALB用 / AZ-c）"
  value       = aws_subnet.public_2.id
}

output "private_subnet_id" {
  description = "プライベートサブネット ID（EC2用）"
  value       = aws_subnet.private.id
}

output "alb_dns_name" {
  description = "ALBのDNS名"
  value       = aws_lb.main.dns_name
}

output "ec2_instance_id" {
  description = "EC2インスタンスID"
  value       = aws_instance.main.id
}

output "ec2_private_ip" {
  description = "EC2インスタンスのプライベートIP"
  value       = aws_instance.main.private_ip
}

output "ec2_key_file" {
  description = "秘密鍵ファイルのパス（Windowsパスワード復号に使用）"
  value       = local_sensitive_file.ec2_private_key.filename
}

output "nat_gateway_ip" {
  description = "NAT GatewayのElastic IP"
  value       = aws_eip.nat.public_ip
}

output "alb_logs_bucket" {
  description = "ALBアクセスログ保存先S3バケット名"
  value       = aws_s3_bucket.alb_logs.id
}
