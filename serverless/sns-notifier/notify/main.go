package main

import (
	"context"
	"fmt"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/awserr"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/ses"
)

const (
	from = "sns-notifier@audit.lingrino.com"
	to   = "srlingren@gmail.com"

	subject = "SNS Notifier: Alert On %s"

	// This could be way better if the JSON was formatted and highlighted
	htmlBody = "<h2>SNS Notifier</h2>" +
		"Source: %s" +
		"<pre><code>" +
		"%s" +
		"</code></pre>"

	textBody = "SNS Notifier\nSource: %s\n%s"
)

func main() {
	lambda.Start(Handler)
}

// Handler handles our SNS events
func Handler(ctx context.Context, snsEvent events.SNSEvent) {
	// Create an SES session
	awsC, err := session.NewSession(&aws.Config{
		Region: aws.String("us-east-1")},
	)
	if err != nil {
		fmt.Println(err)
	}
	sesC := ses.New(awsC)

	// Send an email for each SNS event
	for _, record := range snsEvent.Records {
		snsRecord := record.SNS
		snsARN := snsRecord.TopicArn
		snsMSG := snsRecord.Message

		// Build an Email Struct
		emailInput := &ses.SendEmailInput{
			Source: aws.String(from),
			Destination: &ses.Destination{
				CcAddresses: []*string{},
				ToAddresses: []*string{
					aws.String(to),
				},
			},
			Message: &ses.Message{
				Subject: &ses.Content{
					Charset: aws.String("UTF-8"),
					Data:    aws.String(fmt.Sprintf(subject, snsARN)),
				},
				Body: &ses.Body{
					Html: &ses.Content{
						Charset: aws.String("UTF-8"),
						Data:    aws.String(fmt.Sprintf(htmlBody, snsARN, snsMSG)),
					},
					Text: &ses.Content{
						Charset: aws.String("UTF-8"),
						Data:    aws.String(fmt.Sprintf(textBody, snsARN, snsMSG)),
					},
				},
			},
		}

		// Send the Email
		result, err := sesC.SendEmail(emailInput)
		if err != nil {
			if aerr, ok := err.(awserr.Error); ok {
				switch aerr.Code() {
				case ses.ErrCodeMessageRejected:
					fmt.Println(ses.ErrCodeMessageRejected, aerr.Error())
				case ses.ErrCodeMailFromDomainNotVerifiedException:
					fmt.Println(ses.ErrCodeMailFromDomainNotVerifiedException, aerr.Error())
				case ses.ErrCodeConfigurationSetDoesNotExistException:
					fmt.Println(ses.ErrCodeConfigurationSetDoesNotExistException, aerr.Error())
				default:
					fmt.Println(aerr.Error())
				}
			} else {
				fmt.Println(err.Error())
			}
			return
		}

		// Log Result
		fmt.Println("Email Sent to address: " + to)
		fmt.Println(result.MessageId)
	}
}
