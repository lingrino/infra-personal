resource "pagerduty_schedule" "main" {
  name      = "main"
  time_zone = "America/Los_Angeles"

  layer {
    name                         = "main"
    start                        = "2000-01-01T00:00:00-08:00"
    rotation_virtual_start       = "2000-01-01T00:00:00-08:00"
    rotation_turn_length_seconds = 86400
    users                        = [pagerduty_user.lingrino.id]
  }
}
