resource "aws_sqs_queue" "tt_queue" {
  name                      = "tt_queue"
  delay_seconds             = 5
  max_message_size          = 2048
  message_retention_seconds = 3600
  receive_wait_time_seconds = 10

  tags = {
    Name   = "Tech task SQS queue"
    Source = "Tech Task"
  }
}

data "aws_iam_policy_document" "tt_sqs_policy_document" {
  statement {
    sid = "basic-read-write"
    effect = "Allow"

    principals {
      type = "AWS"
      identifiers = [ "${aws_iam_role.profile_role.arn}" ]
    }

    actions = [
      "SQS:SendMessage",
      "SQS:ChangeMessageVisibility",
      "SQS:DeleteMessage",
      "SQS:ReceiveMessage"
    ]

    resources = [
      "${aws_sqs_queue.tt_queue.arn}",
    ]
  }
}

# Without sleep tt_queue_policy failes with "Invalid value for the parameter Policy."
# https://github.com/hashicorp/terraform-provider-aws/issues/13980#issuecomment-725069967
resource "time_sleep" "wait_60_seconds_before_sqs_policy" {
  depends_on = [aws_iam_role.profile_role]

  create_duration = "60s"
}

resource "aws_sqs_queue_policy" "tt_queue_policy" {
  depends_on = [time_sleep.wait_60_seconds_before_sqs_policy]

  queue_url = aws_sqs_queue.tt_queue.id

  policy = data.aws_iam_policy_document.tt_sqs_policy_document.json
}