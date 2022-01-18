variable "environment" {
  type        = string
  description = "environment name"
  default = "dev"
}

variable "default_tags" {
  description = "tags to attach to all resources"
  default = {
    Tool        = "terraform"
    User        = "Tobi.Ogebule"
  }
}

variable "subnet_name" {
  description = "Map of subnet names"
  type        = map
  default     = {
    WebSubnet = {
        display_name   = "WebSubnet"
        cidr_block     = "10.0.0.0/24" 
    },
    AppSubnet = {
        display_name   = "AppSubnet"
        cidr_block     = "10.0.1.0/24"
    },
    DBSubnet = {
        display_name   = "DBSubnet"
        cidr_block     = "10.0.2.0/24"
    }
  }
}


