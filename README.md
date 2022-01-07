# terraform-libvirt-lfs201

A small project using [Terraform](https://www.terraform.io/) to deploy a ubuntu, fedora, and centos instances on [KVM](https://wikipedia.org/wiki/KVM) for training purposes.

## Install the necessary components and dependencies

## Operating system

* [Ubuntu Server 21.10](https://releases.ubuntu.com/21.10/ubuntu-21.10-live-server-amd64.iso) for bare metal
* [focal-server-cloudimg-amd64.img](https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img) for ubuntu
* [Fedora-Cloud-Base-35-1.2.x86_64.raw.xz](https://download.fedoraproject.org/pub/fedora/linux/releases/35/Cloud/x86_64/images/Fedora-Cloud-Base-35-1.2.x86_64.raw.xz) for fedora - extract and convert using qemu-image to .qcow2
* [CentOS-7-x86_64-GenericCloud-2111.qcow2](https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud-2111.qcow2) for virtual machines

## Run hostconfig.sh on baremetal host

This will do a bunch of things including installing necessary packages, configuring your network interface, creating a bridge, creating a libvirt storage pool, and downloading cloud images.

* Assumes existence of /mnt/kvm directory. Consider mounting this to a logical volume.

```bash
sudo sh hostconfig.sh
```

## Configure terraform files as necessary

* Update netplan to match your network environment.
* Update cloud_init to match your network environment and supply your own ssh public keys.

## After all components are installed

### Terraform

Initialize a Terraform working directory

```bash
terraform init
```

Generate and show Terraform execution plan

```bash
terraform plan
```

Then build your Terraform infrastructure

```bash
terraform apply
```

Check your infrastructure use virsh

```bash
virsh list --all
```

You can destroy your Terraform infrastructure

```bash
terraform destroy
```

## Disclaimer

The gitlab instance data will be destroyed every time the VM is destroyed - you will need to come up with a backup/restore solution if you want data to persist.

### Gitlab Docs

[Backup and Restore Gitlab](https://docs.gitlab.com/ee/raketasks/backup_restore.html)