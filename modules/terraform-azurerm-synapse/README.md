# terraform-azurerm-synapse
Terraform module to create a Synapse solution (Workspace, SQL & Spark pools, firewall rules and private link hub).

## Description
Azure Synapse is an enterprise analytics service that accelerates time to insight across data warehouses and big data systems. Azure Synapse brings together the best of SQL technologies used in enterprise data warehousing, Spark technologies used for big data, Pipelines for data integration and ETL/ELT, and deep integration with other Azure services such as Power BI, CosmosDB, and AzureML.

This module enables the creation of the following resources:

- 1 Synapse workspace
- Dedicated SQL pools. The possibility to create 1 or multiple Dedicated SQL pools configured to the workspace.
- Apache Spark pools. The possibility to create 1 or multiple Apache Spark pools configured to the workspace.
- Synapse firewall rules. The possibility to create 1 or multiple firewall rules configured to the workspace.

## Module example use
```hcl
module "synapse_resources" {
  source = "../../modules/terraform-azurerm-synapse"

  workspace_name                       = "demoworkspace001"
  resource_group_name                  = "cu0-lnd1-t-synapse-demo"
  location                             = "westeurope"
  storage_data_lake_gen2_filesystem_id = "https://sadatalake0501.dfs.core.windows.net/synapsefs"
  sql_administrator_login              = "SqlAdmin"
  sql_administrator_login_password     = "Sup3rS3cureP@ss!"
  managed_virtual_network_enabled      = true
  data_exfiltration_protection_enabled = true
  workspace_tags                       = {
    "AtosManaged" = "true"
    "Environment" = "Test"
  }

  synapse_private_link_hub_name = "demoplhub001"

  sql_pools      =  { 
   "sqldemopool01" = {
      collation   = "SQL_LATIN1_GENERAL_CP1_CI_AS"
      create_mode = "Default"
      sku_name    = "DW100c"
      tags = {
        "AtosManaged"      = "true"
        "AtosMonitoringID" = "sqlpool1"
      }
    }
  }

  spark_pools    = {
    "sparkdemopool01" = {
      delay_in_minutes = 5
      max_node_count = 6
      min_node_count = 3
      node_size = "Small"
      node_size_family = "MemoryOptimized"
      spark_version = "2.4"
      tags = {
        "AtosManaged"      = "true"
       "AtosMonitoringID" = "sparkpool1"
      }
    }
  }

  firewall_rules = {
    "AllowAll" = {
      end_ip_address = "255.255.255.255"
      start_ip_address = "0.0.0.0"
    }
  }

}

```
## Module Arguments

| Name                                   | Type          | Required | Description                                                                                                                         |
|----------------------------------------|---------------|----------|-------------------------------------------------------------------------------------------------------------------------------------|
| `workspace_name`                       | `string`      | true     | Specifies the name which should be used for this synapse Workspace.                                                                 |
| `resource_group_name`                  | `string`      | true     | Specifies the name of the Resource Group where the synapse Workspace should exist.                                                  |
| `location`                             | `string`      | true     | Specifies the Azure Region where the synapse Workspace should exist.                                                                |
| `storage_data_lake_gen2_filesystem_id` | `string`      | true     | Specifies the ID of storage data lake gen2 filesystem resource.                                                                     |
| `sql_administrator_login`              | `string`      | true     | Specifies The Login Name of the SQL administrator.                                                                                  |
| `sql_administrator_login_password`     | `string`      | true     | The Password associated with the sql_administrator_login for the SQL administrator.                                                 |
| `managed_virtual_network_enabled`      | `bool`        | true     | Is Virtual Network enabled for all computes in this workspace?                                                                      |
| `data_exfiltration_protection_enabled` | `bool`        | true     | Is data exfiltration protection enabled in this workspace? If set to true, managed_virtual_network_enabled must also be set to true |
| `workspace_tags`                       | `map(string)` | true     | A mapping of tags which should be assigned to the resource                                                                          |
| `synapse_private_link_hub_name`        | `string`      | true     | The name which should be used for this Synapse Private Link Hub.                                                                    |
| `sql_pools`                            | `map(object)` | true     | Provide the SQL Pool name, the SKU Name for this Synapse Sql Pool and how to create SQL Pool.                                       |
| `spark_pools`                          | `map(object)` | true     | Provide the Spark Pool name, node information, spark version & autoscaling details (min & max node counts).                         |
| `firewall_rules`                       | `map(object)` | true     | Provide the firewall rule name and the range of the ip addresses (start & end ip address).                                          |

For a complete list of all the possible arguments (terraform variables), see the variables.tf file in this modules folder.

## Module outputs

| Name                  | Description                                                                | Value                                                                |
|-----------------------|----------------------------------------------------------------------------|----------------------------------------------------------------------|
| `workspace_endpoints` | The endpoints which can be used to connect to a created Synapse workspace. | `azurerm_synapse_workspace.synapse_workspace.connectivity_endpoints` |
| `workspace_id`        | The resource ID of the created Synapse workspace.                          | `azurerm_synapse_workspace.synapse_workspace.id`                     |
| `privatelink_hub_id`  | The resource ID of the created Private link hub.                           | `azurerm_synapse_private_link_hub.synapse_private_link_hub.id`       |

## License
Atos, all rights protected - 2021.
