resource "azurerm_resource_group" "storeterra" {
  name     = "Practice-Terraform-RG"
  location = "East US"
}
 
resource "azurerm_storage_account" "saterra" {
  name                     = "terrasa2403"
  resource_group_name      = azurerm_resource_group.storeterra.name
  location                 = azurerm_resource_group.storeterra.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
 
resource "azurerm_storage_container" "sacontainer" {
  name                  = "terra-container"
  storage_account_id    = azurerm_storage_account.saterra.id
  container_access_type = "private"
}
 
resource "azurerm_virtual_network" "terra_vnet" {
  name                = "terra-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.storeterra.location
  resource_group_name = azurerm_resource_group.storeterra.name
}
 
resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.storeterra.name
  virtual_network_name = azurerm_virtual_network.terra_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
 
resource "azurerm_subnet" "subnet2" {
  name                 = "subnet2"
  resource_group_name  = azurerm_resource_group.storeterra.name
  virtual_network_name = azurerm_virtual_network.terra_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}