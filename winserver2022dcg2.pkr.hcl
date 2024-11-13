# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

source "azure-arm" "imageBuild" {

  azure_tags = {
    "Env"             = "Dev"
    "Image Offer"     = "${var.image_offer}"
    "Image Publisher" = "${var.image_publisher}"
    "Image SKU"       = "${var.image_sku}"
    "Task"            = "Packer"
  }

  build_key_vault_name = "${var.build_key_vault_name}"
  # temp_resource_group_name            = "rg-packer-temp"
  # location                           = "${var.location}"
  build_resource_group_name = "${var.rgNameDisk}"
  client_id                 = "${var.client_id}"
  client_secret             = "${var.client_secret}"
  communicator              = "winrm"
  disk_encryption_set_id    = "${var.disk_encryption_set_id}"

  # USE MARKETPLACE IMAGE AS SOURCE

  image_offer     = "${var.image_offer}"
  image_publisher = "${var.image_publisher}"
  image_sku       = "${var.image_sku}"

  # USE SHARED GALLERY AS SOURCE

  # shared_image_gallery {
  #     subscription = "${var.subscription_id}"
  #     resource_group = "${var.rgName}"
  #     gallery_name = "${var.acgName}"
  #     image_name = "${var.image_name}"
  #     image_version = "${var.source_image_version}"
  # }

  os_type = "Windows"

  # UNCOMMENT THE LINES BELOW TO ENABLE Trusted Launch
  # secure_boot_enabled                 = true
  # vtpm_enabled                        = true

  keep_os_disk      = false
  temp_os_disk_name = "${var.temp_os_disk_name}"

  shared_image_gallery_destination {
    subscription  = "${var.subscription_id}"
    gallery_name  = "${var.acgName}"
    image_name    = "${var.image_name}"
    image_version = "${var.destination_image_version}"
    # replication_regions = ["${var.location}"]
    resource_group = "${var.rgNameimg}"
  }
  # shared_image_gallery_replica_count = 1

  # # Trying Managed Instance Output

  # managed_image_name                 = "${var.managed_image_name}"
  # managed_image_resource_group_name  = "${var.rgName}"

  subscription_id = "${var.subscription_id}"
  tenant_id       = "${var.tenant_id}"
  vm_size         = "${var.vmSize}"
  winrm_insecure  = true
  winrm_timeout   = "7m"
  winrm_use_ssl   = true
  winrm_username  = "packer"
}

build {
  sources = ["source.azure-arm.imageBuild"]

  # Copiar o arquivo Unattend.xml para a VM
  provisioner "file" {
    source      = "autounattend.xml"
    destination = "C:/Windows/System32/Sysprep/autounattend.xml"
  }

   # Executar o Sysprep com o Unattend.xml
  provisioner "powershell" {
    inline = [
      "C:\\Windows\\System32\\Sysprep\\Sysprep.exe /generalize /oobe /shutdown /unattend:C:\\Windows\\System32\\Sysprep\\autounattend.xml"
    ]
  }

  # Arquivo de manifesto de saída
  post-processor "manifest" {
    output     = "packer-manifest.json"
    strip_path = true
    custom_data = {
      run_type     = "test_acg_run"
      subscription = "${var.subscription_id}"
      gallery_name = "${var.acgName}"
      image_name   = "${var.image_name}"
    }
  }
}

