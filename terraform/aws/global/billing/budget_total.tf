resource "aws_budgets_budget" "total" {
  name = "total"

  budget_type  = "COST"
  limit_amount = "10"
  limit_unit   = "USD"

  time_unit         = "MONTHLY"
  time_period_start = "2018-01-01_00:00"
  time_period_end   = "2087-01-01_00:00"

  cost_types {
    use_amortized        = true
    include_subscription = false
  }
}
