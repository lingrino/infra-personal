output "topic_alarm_high_priority_arn" {
  value = "${ aws_sns_topic.alarm_high_priority.arn }"
}

output "topic_email_received_at_churner_io_arn" {
  value = "${ aws_sns_topic.email_received_at_churner_io.arn }"
}

output "topic_email_received_at_srlingren_com_arn" {
  value = "${ aws_sns_topic.email_received_at_srlingren_com.arn }"
}

output "topic_email_received_at_vaku_io_arn" {
  value = "${ aws_sns_topic.email_received_at_vaku_io.arn }"
}

output "topic_all_email_bounces_complaints_arn" {
  value = "${ aws_sns_topic.all_email_bounces_complaints.arn }"
}
