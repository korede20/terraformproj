resource_group_name = "LabRG3"
location = "eastus"
virtual_machine_name = "labvm4"
subnets = [
    {
      name = "subnet1"
      address_prefixes = [ "10.0.1.0/24" ]
    },
    {
      name = "subnet2"
      address_prefixes = [ "10.0.2.0/24" ]
    },
    {
      name = "subnet3"
      address_prefixes = [ "10.0.3.0/24" ]
    }
  ]
subnet_index = 0
stgact = "labstgact1"
virtual_network_name = "VNet2"