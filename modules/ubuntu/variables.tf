variable "bridge" {
  description = "Name of the libvirt netowkr interface to use"
  type        = string
  default     = "br0"
}

variable "ubuntu_count" {
  description = "Number of ubuntus"
  type        = string
  default     = "1"
}

variable "ubuntu_cpus" {
  description = "Number of CPUs to assign to the ubuntus"
  type        = string
  default     = "2"
}

variable "ubuntu_memory" {
  description = "Amount of memory in MiB to assign to the ubuntus"
  type        = string
  default     = "4096"
}

variable "ubuntu_disk_size" {
  description = "Size of the ubuntu disk in bytes"
  type        = string
  default     = "10000000000"
}