resource "azurerm_resource_group" "test" {
  name     = "rgTestTerraform"
  location = "West Europe"
}


resource "azurerm_sql_server" "test" {
  name                         = "mysqlserver-test-terraform"
  resource_group_name          = "${azurerm_resource_group.test.name}"
  location                     = "${azurerm_resource_group.test.location}"
  version                      = "12.0"
  administrator_login          = "LoginAdmin"
  administrator_login_password = "MonmotDePasse45"

  tags = {
    environment = "production"
  }
}
resource "azurerm_app_service_plan" "test" {
  name                = "example-appserviceplan"
  location            = "${azurerm_resource_group.test.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "test" {
  name                = "example-app-service-test-terraform"
  location            = "${azurerm_resource_group.test.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"
  app_service_plan_id = "${azurerm_app_service_plan.test.id}"


}
resource "azurerm_storage_account" "test" {
  name                     = "storagetestterraform578"
  resource_group_name      = "${azurerm_resource_group.test.name}"
  location                 = "${azurerm_resource_group.test.location}"
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "production"
  }
}