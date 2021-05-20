resource "aws_iam_role" "profile_role" {
  name               = "tt_instance_profile_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  tags = {
    Name   = "Tech task instance profile"
    Source = "Tech Task"
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_instance_profile" "tt_instance_profile" {
  name = "tt_profile"
  role = aws_iam_role.profile_role.name
}