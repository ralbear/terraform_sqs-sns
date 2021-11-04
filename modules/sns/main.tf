resource "aws_sns_topic" "topic" {
  name = "${var.topic-name}-${var.env}"
}

resource "aws_sns_topic_policy" "topic-policy" {
  arn = aws_sns_topic.topic.arn
  policy = data.aws_iam_policy_document.iam-sns-topic-policy.json
}

data "aws_iam_policy_document" "iam-sns-topic-policy" {
  policy_id = "__default_policy_ID"
  statement {
    actions = [
      "SNS:Publish",
    ]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        var.aws-account-id,
      ]
    }
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    resources = [
      aws_sns_topic.topic.arn
    ]
    sid = "__default_statement_ID"
  }
}
