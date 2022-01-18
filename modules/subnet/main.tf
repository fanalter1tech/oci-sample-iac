resource "oci_core_subnet" "this" {
  availability_domain = var.availability_domain
  cidr_block          = var.cidr_block
  display_name        = var.display_name
  compartment_id      = var.tenancy_ocid
  vcn_id              = var.vcn_id
  route_table_id      = var.route_table_id
  security_list_ids   = var.security_list_ids
  dhcp_options_id     = var.dhcp_options_id

  freeform_tags = var.freeform_tags
}