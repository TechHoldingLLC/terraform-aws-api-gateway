##################
#  apigw/iam.tf  #
##################

#-----------------------------------
# API gateway cloudwatch role
#-----------------------------------
resource "aws_iam_role" "apigw_cloudwatch" {
  name               = "${var.apigw_name}-cloudwatch-apigw"
  assume_role_policy = data.aws_iam_policy_document.apigw_service_trust_policy.json
}

#-----------------------------------
# APIGW trust policy for role
#-----------------------------------
data "aws_iam_policy_document" "apigw_service_trust_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy" "apigw_cloudwatch" {
  name = "${var.apigw_name}-cloudwatch-logs"
  role = aws_iam_role.apigw_cloudwatch.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:DescribeLogGroups",
                "logs:DescribeLogStreams",
                "logs:PutLogEvents",
                "logs:GetLogEvents",
                "logs:FilterLogEvents"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}
