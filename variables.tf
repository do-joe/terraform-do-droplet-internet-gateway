variable "name_prefix" {
  description = "prefix used for the resources created in this module"
  type        = string
}

variable "igw_count" {
  description = "Number of igws created/"
  type        = number
  default = 1
}

variable "region" {
  description = "DO region slug for the region the droplet will be deployed into"
  type        = string
}

variable "size" {
  description = "DO size slug used for the droplet"
  type        = string
}

variable "image" {
  description = "DO image slug to run on the droplet, must be ubuntu based."
  type        = string

  validation {
    condition     = startswith(var.image, "ubuntu")
    error_message = "The image slug must start with 'ubuntu'."
  }
}

variable "monitoring" {
  description = "Whether monitoring agent is installed"
  type        = bool
  default = true
}

variable "vpc_id" {
  description = "Id of the VPC which the Droplet is connected to"
  type        = string
}

variable "ssh_keys" {
  description = "A list of SSH key IDs or fingerprints to enable in the format [12345, 123456]"
  type        = list(number)
  default = []
}

variable "tags" {
  description = "A list of the tags to be applied to this Droplet"
  type        = list(string)
  default = []
}

variable "doks_cluster_name" {
  description = "DOKS cluster name"
  type        = string
}





