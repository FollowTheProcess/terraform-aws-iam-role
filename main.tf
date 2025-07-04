resource "aws_iam_role" "this" {
  name                 = var.name
  description          = var.description
  assume_role_policy   = data.aws_iam_policy_document.assume_role_aggregated.json
  max_session_duration = var.max_session_duration
  permissions_boundary = var.permissions_boundary
}

resource "aws_iam_policy" "this" {
  count = length(var.policy_documents) > 0 ? 1 : 0

  name        = var.policy_name
  description = var.policy_description
  policy      = data.aws_iam_policy_document.permissions_aggregated.json

  lifecycle {
    postcondition {
      condition     = length(data.aws_iam_policy_document.permissions_aggregated) <= 131072
      error_message = "IAM policies have a maximum size of 131072 characters, got ${length(data.aws_iam_policy_document.permissions_aggregated.json)}"
    }
  }
}

resource "aws_iam_role_policy_attachment" "this" {
  count = length(var.policy_documents) > 0 ? 1 : 0

  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this[0].arn
}

resource "aws_iam_role_policy_attachment" "managed_policy" {
  for_each   = var.managed_policies
  role       = aws_iam_role.this.name
  policy_arn = each.key
}
