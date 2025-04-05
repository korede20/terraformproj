#declaring variables in this file
variable "resource_group_name" {
  type = string
  description = "this variable specifies the resource group name"
}

variable "location" {
  type = string
  description = "this variable specifies the location for deployment"
}

variable "virtual_network_name" {
  type = string
  description = "this variable represents the name of virtual network 2"
}

variable "subnets" {
  type = list(object({
    name = string
    address_prefixes = list(string) 
  }))
  description = "this variable represents subnet1"
}

variable "subnet_index" {
  type = number
}

#creating a variable for storage account
variable "stgact" {
  type = string
  description = "Storage Account Name"
}

#this is a variable for the virtual machine name
variable "virtual_machine_name" {
  type = string
}