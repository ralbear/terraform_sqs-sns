module "sns" {
  for_each = toset(var.domains)
  source = "./modules/sns"
  topic-name = each.key
  env = var.env
  aws-account-id = var.aws-account-id
}

module "sqs-sns" {
  for_each = toset(var.services)
  source = "./modules/sqs-sns"
  topics = var.domains
  env = var.env
  queue-name = each.key
  region = var.aws-region
  account-id = var.aws-account-id
}
