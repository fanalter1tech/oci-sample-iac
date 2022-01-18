provider "oci" {
  tenancy_ocid     = module["global-variables"].tenancy_ocid
  user_ocid        = module["global-variables"].user_ocid
  fingerprint      = module["global-variables"].fingerprint
  private_key_path = module["global-variables"].private_key_path
  region           = module["global-variables"].region
}

module "networking" {
  source = "../../modules/networking"
  tenancy_ocid   = module["global-variables"].tenancy_ocid
  vcn_cidr       = "10.0.0.0/16"
  display_name   = "networking"
  environment    = var.environment
  subnet_name    = var.subnet_name
  default_tags   = var.default_tags
}

# module "groups" {
#   source = "../../modules/groups"

# }