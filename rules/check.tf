


# ruleid: direform.s3.bucket-force-destroy
resource "aws_s3_bucket" "static_name_bucket" {
  force_destroy = true
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {}
    }
  }
}


# ruleid: direform.s3.static-bucket-name
resource "aws_s3_bucket" "static_name_bucket" {
  bucket = "hello-world-bucket"
  asdfthing = true
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {}
    }
  }
}

# ok
resource "aws_s3_bucket" "non_static_name_bucket" {
  bucket = var.asdf
  asdfthing = true
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {}
    }
  }
}
resource "aws_s3_bucket_logging" "log" {
  target_bucket = aws_s3_bucket.non_static_name_bucket.id
  bucket = aws_s3_bucket.static_name_bucket.id
}




resource "aws_s3_bucket_logging" "log" {
  bucket = aws_s3_bucket.ihavealog.id
}

# ok
resource "aws_s3_bucket" "ihavealog" {
  bucket = var.hello_world_bucket
  asdfthing = true
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {}
    }
  }
}

# ruleid: direform.s3.bucket-without-logging
resource "aws_s3_bucket" "somethings_missing" {
  bucket = var.hello_world_bucket
  asdfthing = true
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {}
    }
  }
}

# ok
resource "aws_s3_bucket" "asdf" {
  bucket = var.asdf
  asdfthing = true
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {}
    }
  }
}

# ruleid: direform.s3.bucket-without-logging
resource "aws_s3_bucket" "bucket" {
  bucket = var.hello_world_bucket
  asdfthing = true
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {}
    }
  }
}

resource "aws_s3_bucket_logging" "log" {
  bucket = aws_s3_bucket.asdf.id
}

# ok
resource "aws_s3_bucket" "secondary_bucket" {
  bucket = var.secondary_bucket
  asdfthing = true
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {}
    }
  }
}
resource "aws_s3_bucket_logging" "log" {
  bucket = aws_s3_bucket.secondary_bucket.id
  target_bucket = aws_s3_bucket.my_logging_bucket.id
}

# ok
resource "aws_s3_bucket" "my_logging_bucket" {
  bucket = var.my_logging_bucket
  asdfthing = true
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {}
    }
  }
}

# ok
resource "aws_s3_bucket" "pootlogbucket" {
  count = 1
  bucket = var.pootlogbucket
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {}
    }
  }
}
resource "aws_s3_bucket_logging" "log" {
  target_bucket = aws_s3_bucket.pootlogbucket.id
}


# ruleid: direform.s3.bucket-public-access-block-unsafe
resource "aws_s3_bucket_public_access_block" "bucket_access_block" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


resource "aws_s3_bucket_public_access_block" "bucket_access_block" {
  block_public_acls       = true
}





variable "domain_acm_cert_arn" { type = string }
resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket_website_configuration.bucket_website_configuration.website_endpoint
    # domain_name              = aws_s3_bucket.bucket.bucket_regional_domain_name
    # origin_access_control_id = aws_cloudfront_origin_access_control.default.id
    origin_id                = "website_origin"
    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_keepalive_timeout = 5
      origin_protocol_policy   = "http-only"
      origin_read_timeout      = 30
      origin_ssl_protocols     = [
        # ruleid: direform.ssl.insecure-tls-ssl-usage
        "TLSv1.1",
        # ruleid: direform.ssl.insecure-tls-ssl-usage
        "TLSv1",
        # ruleid: direform.ssl.insecure-tls-ssl-usage
        "SSLv3",
      ]
      origin_ssl_protocols     = [
        # ok
        "TLSv1.2",
      ]

      # ok
      asdf = var.TLSv1
    }
  }
}



# ruleid: direform.apigateway.stage-missing-access-log-settings
resource "aws_apigatewayv2_stage" "gateway_stage" {
  api_id = aws_apigatewayv2_api.gateway_api.id

  name        = "$default"
  auto_deploy = true
}

# ok
resource "aws_apigatewayv2_stage" "gateway_stage" {
  api_id = aws_apigatewayv2_api.gateway_api.id

  name        = "$default"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.apigw_log_group.arn

    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
    })
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = "*"
      Action = "s3:GetObject"
      Resource = "arn:aws:s3:::${var.domain_name}/*"
    }]
  })
}


# ruleid: direform.terraform.insecure-local-backend
terraform {
  key = 15
  backend "local" {
    asdf = 5
  }
  qwer = 1
}

# ruleid: direform.terraform.insecure-local-backend
terraform {
  backend "local" {}
}

# ok
terraform {
  backend "s3" {}
}

# ruleid: direform.s3.bucket-missing-encryption-configuration
resource "aws_s3_bucket" "aloggable_bucket" {
  asdfthing = true
}
resource "aws_s3_bucket_logging" "log" {
  bucket = aws_s3_bucket.my_encryptable_bucket.id
  target_bucket = aws_s3_bucket.aloggable_bucket.id
}

# ok
resource "aws_s3_bucket" "my_encryptable_bucket" {
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        key = "asdf"
      }
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

# ruleid: direform.sqs.missing-encryption-key
resource "aws_sqs_queue" "dead_letter_queue" {
  name = "my-dead-letter-queue"
}

resource "aws_sqs_queue" "main_queue" {
  name                        = "my-main-queue"
  delay_seconds               = 90
  max_message_size            = 2048
  message_retention_seconds   = 86400
  receive_wait_time_seconds   = 10
  redrive_policy = jsonencode({
    maxReceiveCount     = 5
    deadLetterTargetArn = aws_sqs_queue.dead_letter_queue.arn
  })

  kms_master_key_id = aws_kms_key.sqs_key.arn
  kms_data_key_reuse_period_seconds = 300
}

output "main_queue_url" {
  value = aws_sqs_queue.main_queue.url
}

output "dlq_url" {
  value = aws_sqs_queue.dead_letter_queue.url
}






# ruleid: direform.sqs.missing-dlq-alarm
resource "aws_sqs_queue" "some-dlq" {
  kms_master_key_id = aws_kms_key.sqs_key.arn
  name = "my-dead-letter-queue"
}


resource "aws_sqs_queue" "aqueue" {
  kms_master_key_id = aws_kms_key.sqs_key.arn
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.some-dlq.arn
  })

  kms_master_key_id = aws_kms_key.sqs_key.arn
}


resource "aws_sqs_queue" "aqueue" {
  kms_master_key_id = aws_kms_key.sqs_key.arn
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.some-other-dlq.arn
  })

  kms_master_key_id = aws_kms_key.sqs_key.arn
}

# ruleid: direform.sqs.missing-dlq-alarm
resource "aws_sqs_queue" "some-other-dlq" {
  kms_master_key_id = aws_kms_key.sqs_key.arn
  name = "my-dead-letter-queue"
}




# ok
resource "aws_sqs_queue" "dead_letter_queue" {
  kms_master_key_id = aws_kms_key.sqs_key.arn
  name = "my-dead-letter-queue"
}
resource "aws_cloudwatch_metric_alarm" "dead_letter_queue_alarm" {
  alarm_actions = [var.sns_alarm_topic_arn]
  dimensions = {
    QueueName = aws_sqs_queue.dead_letter_queue.name
  }
}

# ok
resource "aws_sqs_queue" "main_queue" {
  kms_master_key_id = aws_kms_key.sqs_key.arn
  name                        = "my-main-queue"
  delay_seconds               = 90
  max_message_size            = 2048
  message_retention_seconds   = 86400
  receive_wait_time_seconds   = 10
  redrive_policy = jsonencode({
    maxReceiveCount     = 5
    deadLetterTargetArn = aws_sqs_queue.dead_letter_queue.arn
  })

  kms_master_key_id = aws_kms_key.sqs_key.arn
  kms_data_key_reuse_period_seconds = 300
}

output "main_queue_url" {
  value = aws_sqs_queue.main_queue.url
}

output "dlq_url" {
  value = aws_sqs_queue.dead_letter_queue.url
}





# ok
resource "aws_sqs_queue" "another_queue" {
  kms_master_key_id = aws_kms_key.sqs_key.arn
  redrive_policy = jsonencode({
    maxReceiveCount     = 5
    deadLetterTargetArn = aws_sqs_queue.another_dlq.arn
  })

  kms_master_key_id = aws_kms_key.sqs_key.arn
  kms_data_key_reuse_period_seconds = 300
}

resource "aws_cloudwatch_metric_alarm" "dead_letter_queue_alarm" {
  alarm_actions = [var.sns_alarm_topic_arn]
  dimensions = {
    QueueName = aws_sqs_queue.another_dlq.name
  }
}

# ok
resource "aws_sqs_queue" "another_dlq" {
  kms_master_key_id = aws_kms_key.sqs_key.arn
  name = "my-dead-letter-queue"
}


# ruleid: direform.sqs.missing-dlq
resource "aws_sqs_queue" "doesnthavedlq" {
  name = "my-dead-letter-queue"
  kms_master_key_id = aws_kms_key.sqs_key.arn
}

# ok
resource "aws_cloudwatch_log_group" "apigw_log_group" {
  name = "/aws/api_gw/${aws_apigatewayv2_api.gateway_api.name}"
  retention_in_days = 900
  kms_key_id = aws_kms_key.asdf.id
}

# ruleid: direform.cloudwatch.log-group-retention-insufficient
resource "aws_cloudwatch_log_group" "apigw_log_group" {
  name = "/aws/api_gw/${aws_apigatewayv2_api.gateway_api.name}"
  retention_in_days = 300
  kms_key_id = aws_kms_key.asdf.id
}


# ruleid: direform.cloudwatch.log-group-retention-missing
resource "aws_cloudwatch_log_group" "apigw_log_group" {
  name = "/aws/api_gw/${aws_apigatewayv2_api.gateway_api.name}"
  kms_key_id = "asdf"
}

# ruleid: direform.cloudwatch.log-group-lacks-kms-encryption
resource "aws_cloudwatch_log_group" "apigw_log_group" {
  name = "/aws/api_gw/${aws_apigatewayv2_api.gateway_api.name}"
  retention_in_days = 900
}



# ruleid: direform.secretsmanager.secret-lacks-kms-key
resource "aws_secretsmanager_secret" "first_secret" {
  name = "asdf"
}
resource "aws_secretsmanager_secret_rotation" "example" {
  secret_id           = aws_secretsmanager_secret.first_secret.id
}

# ok
resource "aws_secretsmanager_secret" "some_secret" {
  name = "asdf"
  kms_key_id = "asdf"
}
resource "aws_secretsmanager_secret_rotation" "example" {
  secret_id           = aws_secretsmanager_secret.some_secret.id
  rotation_lambda_arn = aws_lambda_function.example.arn

  rotation_rules {
    automatically_after_days = 30
  }
}



# ruleid: direform.secretsmanager.secret-rotation-disabled
resource "aws_secretsmanager_secret" "asdf_secret" {
  name = "asdf"
  kms_key_id = "asdf"
}


resource "aws_secretsmanager_secret_rotation" "example" {
  secret_id           = aws_secretsmanager_secret.another_secret.id
  rotation_lambda_arn = aws_lambda_function.example.arn

  rotation_rules {
    automatically_after_days = 30
  }
}

# ok
resource "aws_secretsmanager_secret" "another_secret" {
  name = "asdf"
  kms_key_id = "asdf"
}

# ok
resource "aws_cloudwatch_metric_alarm" "cpu_utilization_alarm" {
  alarm_name                = "${local.fullname}-cpu_utilization_alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 300
  statistic                 = "Average"
  threshold                 = 80
  alarm_description         = "This metric monitors ec2 cpu utilization"
  alarm_actions = [var.sns_alarm_topic_arn]
  dimensions = {
    InstanceId = aws_instance.instance.id
  }
}

# ok
resource "aws_cloudwatch_metric_alarm" "cpu_utilization_alarm" {
  alarm_name                = "${local.fullname}-cpu_utilization_alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 300
  statistic                 = "Average"
  threshold                 = 80
  alarm_description         = "This metric monitors ec2 cpu utilization"
  alarm_actions = [var.sns_alarm_topic_arn, resource.another.target]
  dimensions = {
    InstanceId = aws_instance.instance.id
  }
}

# ruleid: direform.cloudwatch.alarm-without-action
resource "aws_cloudwatch_metric_alarm" "cpu_utilization_alarm2" {
}

# ruleid: direform.cloudwatch.alarm-without-action
resource "aws_cloudwatch_metric_alarm" "cpu_utilization_alarm2" {
  alarm_actions = []
}
