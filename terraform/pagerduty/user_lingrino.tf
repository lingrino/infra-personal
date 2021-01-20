#################################
### User                      ###
#################################
resource "pagerduty_user" "lingrino" {
  name  = "Sean Lingren"
  email = "sean@lingrino.com"
  role  = "owner"
}

#################################
### Contact Methods           ###
#################################
resource "pagerduty_user_contact_method" "lingrino_email" {
  user_id = pagerduty_user.lingrino.id
  type    = "email_contact_method"
  address = "sean@lingrino.com"
  label   = "main"
}

resource "pagerduty_user_contact_method" "lingrino_phone" {
  user_id      = pagerduty_user.lingrino.id
  type         = "phone_contact_method"
  country_code = "+1"
  address      = "9166127832"
  label        = "main"
}

resource "pagerduty_user_contact_method" "lingrino_sms" {
  user_id      = pagerduty_user.lingrino.id
  type         = "sms_contact_method"
  country_code = "+1"
  address      = "9166127832"
  label        = "main"
}

resource "pagerduty_user_contact_method" "lingrino_push" {
  user_id = pagerduty_user.lingrino.id
  type    = "push_notification_contact_method"
  address = "73f3c61a5afb18cc57661199ec72ade01dfdaa1c28782ac90a67d86f7846b642"
  label   = "lingrino-phone"
}

#################################
### Low Priority Escalations  ###
#################################
resource "pagerduty_user_notification_rule" "lingrino_low_email" {
  user_id                = pagerduty_user.lingrino.id
  start_delay_in_minutes = 0
  urgency                = "low"

  contact_method = {
    type = "email_contact_method"
    id   = pagerduty_user_contact_method.lingrino_email.id
  }
}

resource "pagerduty_user_notification_rule" "lingrino_low_push" {
  user_id                = pagerduty_user.lingrino.id
  start_delay_in_minutes = 0
  urgency                = "low"

  contact_method = {
    type = "push_notification_contact_method"
    id   = pagerduty_user_contact_method.lingrino_push.id
  }
}

#################################
### High Priority Escalations ###
#################################
resource "pagerduty_user_notification_rule" "lingrino_high_email" {
  user_id                = pagerduty_user.lingrino.id
  start_delay_in_minutes = 0
  urgency                = "high"

  contact_method = {
    type = "email_contact_method"
    id   = pagerduty_user_contact_method.lingrino_email.id
  }
}

resource "pagerduty_user_notification_rule" "lingrino_high_sms" {
  user_id                = pagerduty_user.lingrino.id
  start_delay_in_minutes = 0
  urgency                = "high"

  contact_method = {
    type = "sms_contact_method"
    id   = pagerduty_user_contact_method.lingrino_sms.id
  }
}

resource "pagerduty_user_notification_rule" "lingrino_high_push" {
  user_id                = pagerduty_user.lingrino.id
  start_delay_in_minutes = 2
  urgency                = "high"

  contact_method = {
    type = "push_notification_contact_method"
    id   = pagerduty_user_contact_method.lingrino_push.id
  }
}

resource "pagerduty_user_notification_rule" "lingrino_high_phone" {
  user_id                = pagerduty_user.lingrino.id
  start_delay_in_minutes = 2
  urgency                = "high"

  contact_method = {
    type = "phone_contact_method"
    id   = pagerduty_user_contact_method.lingrino_phone.id
  }
}
