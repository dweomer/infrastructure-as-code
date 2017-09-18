provider "github" {
  base_url     = "${var.base_url}"
  organization = "${var.organization}"
  token        = "${var.token}"
}

variable "base_url" {
  description = "GITHUB_BASE_URL"
  default     = "https://api.github.com"
}

variable "organization" {
  description = "GITHUB_ORGANIZATION"
  default     = ""
}

variable "token" {
  description = "GITHUB_TOKEN"
}
