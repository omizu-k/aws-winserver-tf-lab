# 現在のAWSアカウントID取得（バケットポリシーで使用）
data "aws_caller_identity" "current" {}

# ALBアクセスログ保存用S3バケット
resource "aws_s3_bucket" "alb_logs" {
  bucket              = "${var.project_name}-alb-logs-${data.aws_caller_identity.current.account_id}"
  object_lock_enabled = true

  tags = {
    Name = "${var.project_name}-alb-logs"
  }
}

# パブリックアクセスブロック
resource "aws_s3_bucket_public_access_block" "alb_logs" {
  bucket = aws_s3_bucket.alb_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# バージョニング（オブジェクトロックに必須）
resource "aws_s3_bucket_versioning" "alb_logs" {
  bucket = aws_s3_bucket.alb_logs.id

  versioning_configuration {
    status = "Enabled"
  }
}

# オブジェクトロック設定（90日間 GOVERNANCE モード）
resource "aws_s3_bucket_object_lock_configuration" "alb_logs" {
  bucket = aws_s3_bucket.alb_logs.id

  rule {
    default_retention {
      mode = "GOVERNANCE"
      days = 90
    }
  }
}

# バケットポリシー（ALBサービスからのログ書き込みを許可）
resource "aws_s3_bucket_policy" "alb_logs" {
  bucket = aws_s3_bucket.alb_logs.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::582318560864:root" # ap-northeast-1 ELBサービスアカウント
        }
        Action   = "s3:PutObject"
        Resource = "${aws_s3_bucket.alb_logs.arn}/alb/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.alb_logs]
}
