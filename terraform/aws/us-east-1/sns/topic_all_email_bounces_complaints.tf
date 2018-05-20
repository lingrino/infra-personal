resource "aws_sns_topic" "all_email_bounces_complaints" {
  name         = "all_email_bounces_complaints"
  display_name = "all_email_bounces_complaints"
}

# https://www.terraform.io/docs/providers/aws/r/sns_topic_subscription.html
# sns_topic_subscription does not currently support email as an
# endpoint because it requires manual confirmation. So I have created a
# subscription manually that emails me when sns gets a message
