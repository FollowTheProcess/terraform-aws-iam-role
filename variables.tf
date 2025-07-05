variable "name" {
  description = "The name for the IAM role"
  type        = string

  validation {
    condition     = length(var.name) >= 1 && length(var.name) <= 64
    error_message = "IAM Role Name must be between 1 and 64 characters, got ${length(var.name)}"
  }
}

variable "description" {
  description = "The description of the role"
  type        = string
}

variable "principals" {
  description = <<EOT
  Map of type to list of identifiers to allow assuming the role, similar to the `principals` block but in map form.

  For example instead of the following:

  ```terraform
  principals {
    type        = "Service"
    identifiers = ["cloudfront.amazonaws.com"]
  }
  ```

  You'd enter the following for this variable:

  ```terraform
  principals = {
    "Service" = ["cloudfront.amazonaws.com"]
  }
  ```
  EOT
  type        = map(list(string))
}

variable "assume_role_actions" {
  description = "The IAM action(s) to be granted by the AssumeRole policy"
  type        = list(string)
  default = [
    "sts:TagSession",
    "sts:AssumeRole",
  ]
}

variable "assume_role_conditions" {
  description = "List of conditions to apply to the assume role policy"
  type = list(object({
    test     = string
    variable = string
    values   = list(string)
  }))
  default = []
}

variable "max_session_duration" {
  description = "The maximum session duration (in seconds) for assuming the role. Must be between 3600 and 43200 seconds (1 and 12 hours)"
  type        = number
  default     = 3600

  validation {
    condition     = var.max_session_duration >= 3600 && var.max_session_duration <= 43200
    error_message = "Must be between 3600 and 43200 seconds (1 and 12 hours)"
  }
}

variable "permissions_boundary" {
  description = "The ARN of an IAM policy that will be used as the permissions boundary for the role"
  type        = string
  default     = null
}

variable "policy_name" {
  description = "The name of the role policy that is visible in the IAM policy manager"
  type        = string
  default     = null

  validation {
    condition     = var.policy_name != null ? length(var.policy_name) <= 128 : var.policy_name == null
    error_message = "Policy names if given must be <= 128 characters, got ${length(var.policy_name)}"
  }
}

variable "policy_description" {
  description = "The description of the role policy that is visible in the IAM policy manager"
  type        = string
  default     = null
}

variable "policy_documents" {
  description = "List of JSON IAM policy documents describing the permissions the role is to be granted"
  type        = list(string)
  default     = []
}

variable "managed_policies" {
  description = "List of managed policy ARNs to attach to the created role, up to a maximum of 20"
  type        = set(string)
  default     = []

  validation {
    condition     = length(var.managed_policies) <= 20
    error_message = "A maximum of 20 managed policies may be attached to a single role, got ${length(var.managed_policies)}"
  }
}
