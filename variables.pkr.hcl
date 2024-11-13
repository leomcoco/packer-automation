# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "rgNameimg" {
  type    = string
  default = "rgprimages"
}

variable "rgNameDisk" {
  type    = string
  default = "rgprdiskencryptionsets"
}

variable "acgName" {
  type    = string
  default = "acgDemo"
}

variable "image_name" {
  type    = string
  default = "winserver2022"
}

variable "build_key_vault_name" {
  type    = string
  default = "kvdiskencryptionleo"
}

variable "build_revision" {
  type    = string
  default = "001"
}

variable "disk_encryption_set_id" {
  type    = string
  default = "/subscriptions/de810171-07ff-4939-a404-a9a1e5e67487/resourceGroups/rgprdiskencryptionsets/providers/Microsoft.Compute/diskEncryptionSets/diskencryptionleo"
}

variable "image_offer" {
  type    = string
  default = "WindowsServer"
}

variable "image_publisher" {
  type    = string
  default = "MicrosoftWindowsServer"
}

variable "image_sku" {
  type    = string
  default = "2022-datacenter-g2"
}

variable "temp_os_disk_name" {
  type    = string
  default = "osDisk001"
}

variable "location" {
  type    = string
  default = "East US"
}

variable "vmSize" {
  type    = string
  default = "Standard_DS3_V2"
}

variable "subscription_id" {
  type    = string
  default = ""
}

variable "tenant_id" {
  type    = string
  default = ""
}

variable "client_id" {
  type    = string
  default = ""
}

variable "client_secret" {
  type    = string
  default = ""
}

variable "Release" {
  type    = string
  default = "COOL"
}

variable "destination_image_version" {
  type = string
}





