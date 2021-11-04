# Terraform SQS-SNS

This terraform modules allow you to create SNS topics with SQS queues to simplify the setup for listen a specific SNS topic from multiple services.
## Example
This is an example of `terraform.tfvars`

```
aws-access-key = "<awsAccessKey>"
aws-secret-key = "<awsSecretKey>"
aws-region = "<region>"
aws-account-id = <accountId>

env = "prod"
domains = ["user","product","order","payment"]
services = ["notification","paymentProcessor","invoiceGenerator"]
```

This configuration above will create the next sns/sqs config:

- arn:aws:sns:region:account:user-prod
  - arn:aws:sqs:region:account:notification-prod
  - arn:aws:sqs:region:account:paymentProcessor-prod
  - arn:aws:sqs:region:account:invoiceGenerator-prod
  
- arn:aws:sns:region:account:product-prod
  - arn:aws:sqs:region:account:notification-prod
  - arn:aws:sqs:region:account:paymentProcessor-prod
  - arn:aws:sqs:region:account:invoiceGenerator-prod
  
- arn:aws:sns:region:account:order-prod
  - arn:aws:sqs:region:account:notification-prod
  - arn:aws:sqs:region:account:paymentProcessor-prod
  - arn:aws:sqs:region:account:invoiceGenerator-prod
  
- arn:aws:sns:region:account:payment-prod
  - arn:aws:sqs:region:account:notification-prod
  - arn:aws:sqs:region:account:paymentProcessor-prod
  - arn:aws:sqs:region:account:invoiceGenerator-prod
  

## ToDo
- Define a more detailed domain/services list where a service can listen some domains only
