resource "aws_budgets_budget" "high" {
  provider = aws.us-east-1

  name = "high"

  budget_type  = "COST"
  limit_amount = "15.0"
  limit_unit   = "USD"

  time_unit         = "MONTHLY"
  time_period_start = "2018-01-01_00:00"
  time_period_end   = "2087-01-01_00:00"

  cost_types {
    use_amortized        = true
    include_subscription = false
  }

  notification {
    notification_type          = "FORECASTED"
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    subscriber_email_addresses = ["sean+aws-root@lingren.com"]
  }
}

resource "aws_budgets_budget" "very_high" {
  provider = aws.us-east-1

  name = "very_high"

  budget_type  = "COST"
  limit_amount = "25.0"
  limit_unit   = "USD"

  time_unit         = "MONTHLY"
  time_period_start = "2018-01-01_00:00"
  time_period_end   = "2087-01-01_00:00"

  cost_types {
    use_amortized        = true
    include_subscription = false
  }

  notification {
    notification_type          = "FORECASTED"
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    subscriber_email_addresses = ["sean+aws-root@lingren.com"]
  }
}
