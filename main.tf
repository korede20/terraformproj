#creating a Resorce Group
resource "azurerm_resource_group" "LabRG3" {
    name = var.resource_group_name
    location = var.location
}

resource "azurerm_storage_account" "example" {
  name                     = var.stgact
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}

#creating a virtual network
resource "azurerm_virtual_network" "TerraformNetwork" {
    name = var.virtual_network_name
    location = var.location
    resource_group_name = var.resource_group_name
    address_space = [ "10.0.0.0/16" ]

    tags = {
        environment = "Lab3"
    }
}

#Creating new subnets
resource "azurerm_subnet" "subnets" {
    count = 3
    name = var.subnets[count.index].name
    resource_group_name = azurerm_resource_group.LabRG3.name
    virtual_network_name = azurerm_virtual_network.TerraformNetwork.name
    address_prefixes = var.subnets[count.index].address_prefixes
}

#create linux private key
resource "tls_private_key" "linuxkey" {
  algorithm = "RSA"
  rsa_bits = 4096
}

#Saving the private key to local machine
resource "local_file" "linuxkey" {
  filename = "linuxkey.pem"
  content = tls_private_key.linuxkey.private_key_pem
}

#creating a linux virtual machine in subnet2
resource "azurerm_network_interface" "nic" {
  name                = "nic"
  location            = azurerm_resource_group.LabRG3.location
  resource_group_name = azurerm_resource_group.LabRG3.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnets[var.subnet_index].id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_linux_virtual_machine" "Labvm4" {
  name                = "Labvm4"
  resource_group_name = azurerm_resource_group.LabRG3.name
  location            = azurerm_resource_group.LabRG3.location
  size                = "Standard_F2"
  admin_username      = "korede"
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  admin_ssh_key {
    username   = "korede"
    public_key = tls_private_key.linuxkey.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  depends_on = [ azurerm_network_interface.nic, 
  tls_private_key.linuxkey, azurerm_virtual_network.TerraformNetwork 
  ]
}

