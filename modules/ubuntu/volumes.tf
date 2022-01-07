resource "libvirt_volume" "base_ubuntu" {
  name   = "base_ubuntu"
  pool   = "kvm-pool"
  source = "/mnt/kvm/images/focal-server-cloudimg-amd64.qcow2"
  format = "qcow2"
}