module "centos" {
  source           = "./modules/centos"
  bridge           = var.bridge
  centos_count     = var.centos_count
  centos_cpus      = var.centos_cpus
  centos_memory    = var.centos_memory
  centos_disk_size = var.centos_disk_size
}


module "ubuntu" {
  source           = "./modules/ubuntu"
  bridge           = var.bridge
  ubuntu_count     = var.ubuntu_count
  ubuntu_cpus      = var.ubuntu_cpus
  ubuntu_memory    = var.ubuntu_memory
  ubuntu_disk_size = var.ubuntu_disk_size
}

module "fedora" {
  source           = "./modules/fedora"
  bridge           = var.bridge
  fedora_count     = var.fedora_count
  fedora_cpus      = var.fedora_cpus
  fedora_memory    = var.fedora_memory
  fedora_disk_size = var.fedora_disk_size
}