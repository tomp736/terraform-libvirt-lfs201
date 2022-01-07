variable "bridge" {
  description = "Name of the libvirt netowkr interface to use"
  type        = string
  default     = "br0"
}

variable "fedora_count" {
  description = "Number of fedoras"
  type        = string
  default     = "1"
}

variable "fedora_cpus" {
  description = "Number of CPUs to assign to the fedoras"
  type        = string
  default     = "2"
}

variable "fedora_memory" {
  description = "Amount of memory in MiB to assign to the fedoras"
  type        = string
  default     = "4096"
}

variable "fedora_disk_size" {
  description = "Size of the fedora disk in bytes"
  type        = string
  default     = "10000000000"
}