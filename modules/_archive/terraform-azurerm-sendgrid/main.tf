/*
* ## terraform-azurerm-sendgrid
* Terraform module to create a Azure Sendgrid account
* 
* ## Description
*SendGrid is a cloud-based SMTP provider that allows you to send email without having to maintain email servers. Azure hosted Sendgrid is a SaaS platform provided by Sendgrid.
*There is no native way of deploying Azure hosted Sendgrid through Terraform. So we are embeding an ARM template in terraform module.
*Once sendgrid has been deployed click on configure now that will setup an account in sendgrid portal. In Sendgrid protal you can create api keys.
*There isn't much help available but please refer the documentation here for further help https://docs.sendgrid.com/for-developers/partners/microsoft-azure-2021
* Please not if delete a sendgrid account and trying to redeploy you might have wait upto 24 hours before you can redeploy even if it is different name.
* ## Module example use
* ```hcl
*module "send_grid" {
*  source              = "../../modules/terraform-azurerm-sendgrid"
*  sendgrid_name       = var.sendgrid_name
*  resource_group_name = resource.azurerm_resource_group.main.name
*  deployment_mode     = var.arm_deployment_mode
*  sendgrid_properties = var.sendgrid_properties
*  azureSubscriptionId = var.azureSubscriptionId
*  tags                = var.tags
*}

* ## example tfvar file
*sendgrid_name       = "testrb1"
*arm_deployment_mode = "Complete"
*azureSubscriptionId = "759b3d1a-ba3b-46d7-a33c-76c0c6c75932"

*sendgrid_properties = {
*  quantity  = 1
*  autoRenew = true
*  planId    = "Essentials40K"
*  offerId   = "tsg-saas-offer"
*  termId    = "hjdtn7tfnxcy"
*}

*tags = {
*  "Environment"          = "Production"
*  "Billing Identifier"   = "NA"
*}

* ```
*PlanId can take below values
*"free-100",
*"essentials40k",
*"essentials100k",
*"pro-100k",
*"pro-300k",
*"pro-700k",
*"pro-1p5m",
*"pro-2p5m"
*arm_deployment_mode can below values
*Complete
*Incremental
* ## License
* Atos, all rights protected - 2021.
*/


resource "azurerm_resource_group_template_deployment" "sendgrid" {
  name                = var.sendgrid_name
  resource_group_name = var.resource_group_name
  deployment_mode     = var.deployment_mode
  parameters_content = jsonencode({
    "name" : {
      "value" : var.sendgrid_name
    },
    "planId" : {
      "value" : var.sendgrid_properties.planId
    },
    "offerId" : {
      "value" : var.sendgrid_properties.offerId
    },
    "quantity" : {
      "value" : var.sendgrid_properties.quantity
    },
    "termId" : {
      "value" : var.sendgrid_properties.termId
    },
    "azureSubscriptionId" : {
      "value" : var.azureSubscriptionId
    },
    "publisherTestEnvironment" : {
      "value" : ""
    },
    "autoRenew" : {
      "value" : var.sendgrid_properties.autoRenew
    },
    "tags" : {
      "value" : var.tags
    }
  })
  template_content = file("../../modules/terraform-azurerm-sendgrid/sendgrid.json")
}