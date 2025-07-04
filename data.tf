data "aws_iam_policy_document" "assume_role" {
  for_each = var.principals

  statement {
    effect  = "Allow"
    actions = var.assume_role_actions

    principals {
      type        = each.key
      identifiers = each.value
    }

    dynamic "condition" {
      for_each = var.assume_role_conditions
      content {
        test     = condition.value.test
        variable = condition.value.variable
        values   = condition.value.values
      }
    }
  }
}

data "aws_iam_policy_document" "assume_role_aggregated" {
  override_policy_documents = data.aws_iam_policy_document.assume_role[*].json
}

data "aws_iam_policy_document" "permissions_aggregated" {
  override_policy_documents = var.policy_documents
}
