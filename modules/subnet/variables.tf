variable "tenancy_ocid" {
  description = "The OCID of the tenancy."
  type        = string
  default     = "ocid1.tenancy.oc1..aaaaaaaahnckqhwjfwqqbv5lxxcvj74ydps2tok4mboblfenzo7ocvdrtcgq"
}

variable "display_name" {
  type        = string
  description = "display name"
}

variable "availability_domain" {
  type = string
}

variable "cidr_block" {
  type = string
}

variable "compartment_id" {
  type = string
}

variable "vcn_id" {
  type = string
}

variable "route_table_id" {
  type = string
}

variable "security_list_ids" {
  type = list(string)
}

variable "dhcp_options_id" {
  type = string
}

variable "freeform_tags" {}