# Terraform AWS IAM Role

[![License](https://img.shields.io/github/license/FollowTheProcess/terraform-aws-iam-role)](https://github.com/FollowTheProcess/terraform-aws-iam-role)
[![GitHub](https://img.shields.io/github/v/release/FollowTheProcess/terraform-aws-iam-role?logo=github&sort=semver)](https://github.com/FollowTheProcess/terraform-aws-iam-role)
[![CI](https://github.com/FollowTheProcess/terraform-aws-iam-role/workflows/CI/badge.svg)](https://github.com/FollowTheProcess/terraform-aws-iam-role/actions?query=workflow%3ACI)

## Summary

A Terraform module providing an AWS IAM Role

### Example

```terraform
module "role" {
  source = "github.com/FollowTheProcess/terraform-aws-iam-role"

  name        = "my-test-role"
  description = "A role used for testing"
  principals = {
    "Service" = ["route53.amazonaws.com"]
  }
  assume_role_conditions = [
    {
      test     = "StringEquals"
      variable = "aws:PrincipalOrgID"
      values   = ["o-sabhong3hu"]
    }
  ]
  policy_name        = "my-test-role-policy"
  policy_description = "IAM Policy granting the test role permissions to do stuff"
  policy_documents   = [data.aws_iam_policy_document.bucket_access.json]
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.12 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.21.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.managed_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.assume_role_aggregated](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.permissions_aggregated](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assume_role_actions"></a> [assume\_role\_actions](#input\_assume\_role\_actions) | The IAM action(s) to be granted by the AssumeRole policy | `list(string)` | <pre>[<br/>  "sts:TagSession",<br/>  "sts:AssumeRole"<br/>]</pre> | no |
| <a name="input_assume_role_conditions"></a> [assume\_role\_conditions](#input\_assume\_role\_conditions) | List of conditions to apply to the assume role policy | <pre>list(object({<br/>    test     = string<br/>    variable = string<br/>    values   = list(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the role | `string` | n/a | yes |
| <a name="input_managed_policies"></a> [managed\_policies](#input\_managed\_policies) | List of managed policy ARNs to attach to the created role, up to a maximum of 20 | `set(string)` | `[]` | no |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | The maximum session duration (in seconds) for assuming the role. Must be between 3600 and 43200 seconds (1 and 12 hours) | `number` | `3600` | no |
| <a name="input_name"></a> [name](#input\_name) | The name for the IAM role | `string` | n/a | yes |
| <a name="input_permissions_boundary"></a> [permissions\_boundary](#input\_permissions\_boundary) | The ARN of an IAM policy that will be used as the permissions boundary for the role | `string` | `null` | no |
| <a name="input_policy_description"></a> [policy\_description](#input\_policy\_description) | The description of the role policy that is visible in the IAM policy manager | `string` | `null` | no |
| <a name="input_policy_documents"></a> [policy\_documents](#input\_policy\_documents) | List of JSON IAM policy documents describing the permissions the role is to be granted | `list(string)` | `[]` | no |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | The name of the role policy that is visible in the IAM policy manager | `string` | `""` | no |
| <a name="input_principals"></a> [principals](#input\_principals) | Map of type to list of identifiers to allow assuming the role, similar to the `principals` block but in map form.<br/><br/>  For example instead of the following:<pre>terraform<br/>  principals {<br/>    type        = "Service"<br/>    identifiers = ["cloudfront.amazonaws.com"]<br/>  }</pre>You'd enter the following for this variable:<pre>terraform<br/>  principals = {<br/>    "Service" = ["cloudfront.amazonaws.com"]<br/>  }</pre> | `map(list(string))` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the role |
| <a name="output_name"></a> [name](#output\_name) | The name of the created IAM role |
| <a name="output_policy"></a> [policy](#output\_policy) | Role policy document in JSON format |
| <a name="output_unique_id"></a> [unique\_id](#output\_unique\_id) | The stable and unique string identifying the role |
<!-- END_TF_DOCS -->