provider "aws" {
  region = "us-west-2"
}

resource "aws_kms_key" "sqs_key" {
  description             = "KMS key for SQS encryption"
  deletion_window_in_days = 10
}

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

