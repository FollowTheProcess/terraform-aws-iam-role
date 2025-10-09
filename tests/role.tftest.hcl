mock_provider "aws" {
  mock_data "aws_iam_policy_document" {
    defaults = {
      json = "{}"
    }
  }
}

run "name_too_long" {
  variables {
    name        = "something-very-long-lots-of-characters-more-than-the-limit-more-words-here-blah"
    description = "required"
    principals = {
      "Service" = ["cloudfront.amazonaws.com"]
    }
  }

  command = plan

  expect_failures = [var.name]
}

run "max_session_duration_too_low" {
  variables {
    name        = "test"
    description = "required"
    principals = {
      "Service" = ["cloudfront.amazonaws.com"]
    }
    max_session_duration = 20
  }

  command = plan

  expect_failures = [var.max_session_duration]
}

run "max_session_duration_too_high" {
  variables {
    name        = "test"
    description = "required"
    principals = {
      "Service" = ["cloudfront.amazonaws.com"]
    }
    max_session_duration = 99999
  }

  command = plan

  expect_failures = [var.max_session_duration]
}
