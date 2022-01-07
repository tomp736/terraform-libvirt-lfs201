resource "libvirt_volume" "base_fedora" {
  name   = "base_fedora"
  pool   = "kvm-pool"
  source = "/mnt/kvm/images/fedora-cloudimg-35-1.2.qcow2"
  format = "qcow2"
}