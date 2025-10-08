locals {
  stack_name = "api-gateway-layer"

  api_subdomain   = var.environment
  api_domain_name = var.environment == "prod" ? "eligibility-signposting-api.national.nhs.uk" : "eligibility-signposting-api.nhs.uk"
}
