source "vsphere-iso" "linux-ubuntu-server" {
  vcenter_server = var.vsphere_server
  username = var.vsphere_user
  password = var.vsphere_password
  datacenter = var.datacenter
  datastore = var.datastore
  host = var.host
  cluster = var.cluster
  folder = var.folder
  insecure_connection = true
  tools_upgrade_policy = true
  remove_cdrom = true
  convert_to_template = true
  guest_os_type = var.guest_os_type
  vm_version = 14
  notes = "Built by HashiCorp Packer on ${local.buildtime}."
  vm_name = var.vm_name
  firmware = "bios"

  snapshot_name = "Snapshot"
  create_snapshot = true

  CPUs = var.cpu_num
  cpu_cores = var.cpu_cores
  CPU_hot_plug = false
  RAM = var.ram
  RAM_hot_plug = false

  cdrom_type = "sata"
  disk_controller_type = ["pvscsi"]
  storage {
    disk_size = var.disk_size
    disk_controller_index = 0
    disk_thin_provisioned = true
    disk_eagerly_scrub = false
  }
  network_adapters {
    network = var.network_name
    network_card = "vmxnet3"
  }
  iso_url = var.iso_url
  // iso_paths = ["[${ var.vcenter_datastore }] /${ var.iso_path }/${ var.iso_file }"]
  iso_checksum = var.iso_checksum
  http_directory = "http"
  boot_order = "disk,cdrom"
  boot_wait = "5s"
  cd_files = [
        "./http/meta-data",
        "./http/user-data"]
  cd_label = "cidata"
  boot_command = [
    "<esc><esc><esc>",
    "<enter><wait>",
    "/casper/vmlinuz ",
    "initrd=/casper/initrd ",
    "autoinstall ",
    "boot<enter>"
  ]
  ip_wait_timeout = "20m"
  ssh_password = var.ssh_password
  ssh_username = var.ssh_user
  ssh_port = 22
  ssh_timeout = "30m"
  ssh_handshake_attempts = "100"
  shutdown_command = "echo '${var.ssh_password}' | sudo -S -E shutdown -P now"
  shutdown_timeout = "15m"
}

build {
  sources = [
    "source.vsphere-iso.linux-ubuntu-server"]
  provisioner "shell" {
    execute_command = "echo '${var.ssh_password}' | {{.Vars}} sudo -S -E bash '{{.Path}}'"
    environment_vars = [
      "BUILD_USERNAME=${var.ssh_user}",
    ]
    scripts = ["./scripts/setup_ubuntu2004.sh"]
    expect_disconnect = true
  }
 }
