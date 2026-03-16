variable "aws_region" {
  description = "AWSリージョン"
  type        = string
  default     = "ap-northeast-1"
}

variable "project_name" {
  description = "プロジェクト名（リソース名のプレフィックスに使用）"
  type        = string
  default     = "myapp"
}

variable "vpc_cidr" {
  description = "VPCのCIDRブロック"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  description = "パブリックサブネット1のCIDR（ALB用 / AZ-a）"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  description = "パブリックサブネット2のCIDR（ALB用 / AZ-c、冗長構成）"
  type        = string
  default     = "10.0.2.0/24"
}

variable "nat_subnet_cidr" {
  description = "NATサブネットのCIDR（NAT Gateway専用 / AZ-a）"
  type        = string
  default     = "10.0.3.0/24"
}

variable "private_subnet_cidr" {
  description = "プライベートサブネットのCIDR（EC2用）"
  type        = string
  default     = "10.0.10.0/24"
}

variable "ec2_instance_type" {
  description = "EC2インスタンスタイプ"
  type        = string
  default     = "t3.medium"
}
