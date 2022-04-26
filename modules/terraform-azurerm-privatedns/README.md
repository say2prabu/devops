# terraform-azurerm-privatedns
Terraform module to create an Azure Private DNS instance.

## Description
Azure Private DNS provides a reliable and secure DNS service for your virtual network. Azure Private DNS manages and resolves domain names in the virtual network without the need to configure a custom DNS solution. By using private DNS zones, you can use your own custom domain name instead of the Azure-provided names during deployment.

## Module example use
```hcl
module "privatelink_dnszones" {
  source = "../../modules/terraform-azurerm-privatedns"

  name                            = "dnszonename.test.org"
  resource_group_name             = "demo-rsg"
  tags                            = {
      "AtosManaged" = "true"
  }
  
  private_dns_zone_vnet_link_name = "vnet-link-dnszonename"
  virtual_network_id              = "<resource id of existing vnet>"
}

```
## Module Arguments

| Name                  | Type          | Required | Description                                        |
| --------------------- | ------------- | -------- | -------------------------------------------------- |
| `name`                | `object`      | true     | The name of the Private DNS Zone                           |
| `resource_group_name` | `string`      | true     | Specifies the resource group where the resource exists.     |
| `tags`                | `map(string)` | false    | A mapping of tags to assign to the resource group. |
| `private_dns_zone_vnet_link_name`                | `string` | true    | The name of the Private DNS Zone Virtual Network Link. Changing this forces a new resource to be created.|
| `private_dns_zone_name`                | `string` | true    | The name of the Private DNS zone (without a terminating dot). |
| `virtual_network_id `                | `map(string)` | true    |The ID of the Virtual Network that should be linked to the DNS Zone. |


## Module outputs

| Name             | Description                             | Value                                          |
| ---------------- | --------------------------------------- | ---------------------------------------------- |
| `private_dns_id` | The name of the created resource group. | `azurerm_private_dns_zone.private_dns_zone.id` |

## License
Atos, all rights protected - 2021.
