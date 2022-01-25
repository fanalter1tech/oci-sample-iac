provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

module "networking" {
  source = "../../modules/networking"
  tenancy_ocid   = var.tenancy_ocid
  vcn_cidr       = "10.0.0.0/16"
  display_name   = "networking"
  environment    = var.environment
  subnet_name    = var.subnet_name
  default_tags   = var.default_tags
}

# module "groups" {
#   source = "../../modules/groups"

# }