resource "azurerm_resource_group" "main" {
  name     = "${var.resource_group_prefix}-rg"
  location = "North Europe"
}