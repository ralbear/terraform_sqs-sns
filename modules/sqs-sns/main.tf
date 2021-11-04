data "aws_iam_policy_document" "sqs-queue-policy" {
  policy_id = "arn:aws:sqs:${var.region}:${var.account-id}:${var.env}-${var.queue-name}/SQSDefaultPolicy"

  statement {
    sid    = "example-sns-topic"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "SQS:SendMessage",
    ]

    resources = [
      "arn:aws:sqs:${var.region}:${var.account-id}:${var.queue-name}-${var.env}",
    ]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"

      values = formatlist("arn:aws:sns:${var.region}:${var.account-id}:%s-${var.env}", var.topics)
    }
  }
}

resource "aws_sqs_queue" "queue" {
  name     = "${var.queue-name}-${var.env}"
  policy   = data.aws_iam_policy_document.sqs-queue-policy.json
}

resource "aws_sns_topic_subscription" "sns-sqs-subscription" {
  for_each = toset(var.topics)
  topic_arn = "arn:aws:sns:${var.region}:${var.account-id}:${each.key}-${var.env}"
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.queue.arn
}
