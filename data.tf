data "aws_iam_policy_document" "assume_role" {
  # Note: can't use a for-each as we need to do the splat later
  # for the aggregated policy
  count = length(keys(var.principals))

  statement {
    effect  = "Allow"
    actions = var.assume_role_actions

    principals {
      type        = element(keys(var.principals), count.index)
      identifiers = var.principals[element(keys(var.principals), count.index)]
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
