package main

import (
	"context"
	"fmt"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/ses"
	"github.com/aws/aws-sdk-go-v2/service/ses/types"
)

const (
	from = "sns-notifier@audit.lingrino.com"
	to   = "sean@lingrino.com"

	subjectF = "SNS Notifier: Alert On %s"

	// This could be way better if the JSON was formatted and highlighted.
	htmlBodyF = "<h2>SNS Notifier</h2>" +
		"Source: %s" +
		"<pre><code>" +
		"%s" +
		"</code></pre>"

	textBodyF = "SNS Notifier\nSource: %s\n%s"
)

func main() {
	lambda.Start(Handler)
}

// Handler handles our SNS events.
func Handler(ctx context.Context, snsEvent events.SNSEvent) {
	// Create an SES session
	cfg, err := config.LoadDefaultConfig(context.TODO(), config.WithRegion("us-east-1"))

	if err != nil {
		fmt.Println(err)
	}
	sesC := ses.NewFromConfig(cfg)

	// Send an email for each SNS event
	for _, record := range snsEvent.Records {
		snsRecord := record.SNS
		snsARN := snsRecord.TopicArn
		snsMSG := snsRecord.Message

		subject := fmt.Sprintf(subjectF, snsARN)
		htmlBody := fmt.Sprintf(htmlBodyF, snsARN, snsMSG)
		textBody := fmt.Sprintf(textBodyF, snsARN, snsMSG)

		// Build an Email Struct
		emailInput := buildEmailInput(to, from, subject, htmlBody, textBody)

		// Send the Email
		result, err := sesC.SendEmail(context.TODO(), emailInput)
		if err != nil {
			fmt.Println(err.Error())
			return
		}

		// Log Result
		fmt.Println("Email Sent to address: " + to)
		fmt.Println(result.MessageId)
	}
}

// buildEmailInput returns our emailInput struct.
func buildEmailInput(to, from, subject, htmlBody, textBody string) *ses.SendEmailInput {
	return &ses.SendEmailInput{
		Source: aws.String(from),
		Destination: &types.Destination{
			CcAddresses: []string{},
			ToAddresses: []string{to},
		},
		Message: &types.Message{
			Subject: &types.Content{
				Charset: aws.String("UTF-8"),
				Data:    aws.String(subject),
			},
			Body: &types.Body{
				Html: &types.Content{
					Charset: aws.String("UTF-8"),
					Data:    aws.String(htmlBody),
				},
				Text: &types.Content{
					Charset: aws.String("UTF-8"),
					Data:    aws.String(textBody),
				},
			},
		},
	}
}
