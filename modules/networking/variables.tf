variable "tenancy_ocid" {
  description = "The OCID of the tenancy."
  type        = string
  default     = "ocid1.tenancy.oc1..aaaaaaaahnckqhwjfwqqbv5lxxcvj74ydps2tok4mboblfenzo7ocvdrtcgq"
}

variable "default_tags" {
  description = "tags to attach to all resources"
  default = {
    Tool        = "terraform"
    User        = "Tobi.Ogebule"
  }
}

variable "vcn_cidr" {
  type        = string
  description = "environment CIDR block"
}

variable "display_name" {
  type        = string
  description = "display name"
}

variable "environment" {
  type        = string
  description = "environment name"
}


variable "subnet_name" {
  description = "Map of subnet names"
  type        = map
  default     = {
    "WebSubnet" = {
        display_name   = "WebSubnet"
        cidr_block     = "10.0.0.0/24" 
    },
    "AppSubnet" = {
        display_name   = "AppSubnet"
        cidr_block     = "10.0.1.0/24"
    },
    "DBSubnet" = {
        display_name   = "DBSubnet"
        cidr_block     = "10.0.2.0/24"
    }
  }
}
