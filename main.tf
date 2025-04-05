#writing out module block for new test
module "azurevmstorage" {
  source = "../../Firstfolder"
  resource_group_name = var.resource_group_name
  location = var.location
  virtual_machine_name = var.virtual_machine_name
  subnets = var.subnets
  subnet_index = var.subnet_index
  stgact = var.stgact
  virtual_network_name = var.virtual_network_name
}
