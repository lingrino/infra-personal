resource "pagerduty_escalation_policy" "main" {
  name      = "main"
  num_loops = 1

  rule {
    escalation_delay_in_minutes = 15
    target {
      type = "schedule_reference"
      id   = pagerduty_schedule.main.id
    }
  }
}
