variable "bridge" {
  description = "Name of the libvirt netowkr interface to use"
  type        = string
  default     = "br0"
}

variable "centos_count" {
  description = "Number of centoss"
  type        = string
  default     = "1"
}

variable "centos_cpus" {
  description = "Number of CPUs to assign to the centoss"
  type        = string
  default     = "2"
}

variable "centos_memory" {
  description = "Amount of memory in MiB to assign to the centoss"
  type        = string
  default     = "4096"
}

variable "centos_disk_size" {
  description = "Size of the centos disk in bytes"
  type        = string
  default     = "10000000000"
}