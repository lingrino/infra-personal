output "topic_email_received_at_churner_io_arn" {
  value = "${ aws_sns_topic.email_received_at_churner_io.arn }"
}

output "topic_email_received_at_srlingren_com_arn" {
  value = "${ aws_sns_topic.email_received_at_srlingren_com.arn }"
}
