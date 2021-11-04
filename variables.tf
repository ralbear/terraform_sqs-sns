variable "aws-access-key" {
  type = string
}

variable "aws-secret-key" {
  type = string
}

variable "aws-region" {
  type = string
}

variable "aws-account-id" {
  type = string
}

variable "env" {
  type = string
}

variable "domains" {
  type = list(string)
}

variable "services" {
  type = list(string)
}
