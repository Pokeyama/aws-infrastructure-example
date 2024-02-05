# Terraform Backend Configuration
terraform {
  backend "local" {
    path = "./terraform.tfstate"  # Specify the local path for storing Terraform state
  }
}
