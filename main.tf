terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = ">= 2.9.14"
    }
  }
}

provider "proxmox" {
  pm_api_url          = "https://node1.infra.wilders.dev:8006/api2/json"
  pm_api_token_id     = "clement-garcin@pve!formation"
  pm_api_token_secret = var.pm_api_token_secret
  pm_tls_insecure     = true
}

resource "proxmox_lxc" "debian12_container" {
  vmid        = 342
  hostname    = "checkpoint-3-debian-clem"
  target_node = "ns3065162"

  ostemplate = "local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"

  network {
    name   = "eth0"
    bridge = "vmbr2"
    ip     = "192.168.1.222/24"
    gw     = "192.168.1.254"
  }

  cores  = 2
  memory = 2048

  rootfs {
  storage = "local"
  size    = "8G"
}


  password = "root123"
}
