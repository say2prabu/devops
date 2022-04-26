resource "random_string" "main" {
  length  = 60
  special = false
  upper   = false
  number  = var.unique-include-numbers
}

resource "random_string" "first_letter" {
  length  = 1
  special = false
  upper   = false
  number  = false
}

resource "random_id" "vm_unique_number" {
  byte_length = 8
}

locals {
  // adding a first letter to guarantee that you always start with a letter
  standard_prefix            = join("-", [var.organization-code, var.subscription-code, var.environment-code])
  region_code                = lookup(var.azure-regions, var.azure_region)
  standard_withregion_prefix = join("-", [var.organization-code, var.subscription-code, var.environment-code, local.region_code])
  random_safe_generation     = join("", [random_string.first_letter.result, random_string.main.result])
  random                     = substr(coalesce(var.unique-seed, local.random_safe_generation), 0, var.unique-length)
  suffix                     = lower(join("-", var.suffix))
  suffix_unique              = lower(join("", concat(var.suffix, [local.random])))
  sasuffix                   = lower(join("", var.suffix))
  sasuffix_unique            = lower(join("", concat(var.suffix, [local.random])))
  analysissuffix             = lower(join("", var.suffix))
  analysissuffix_unique      = lower(join("", concat(var.suffix, [local.random])))
  acrsuffix                  = lower(join("", var.suffix))
  acrsuffix_unique           = lower(join("", concat(var.suffix, [local.random])))


  az = {
    app_service = {
      name        = substr(join("-", compact([local.standard_prefix, "appsvc", local.suffix])), 0, 60)
      name_unique = substr(join("-", compact([local.standard_prefix, "appsvc", local.suffix_unique])), 0, 60)
      min_length  = 2
      max_length  = 60
    }
    app_service_plan = {
      name        = substr(join("-", compact([local.standard_prefix, "appsvcplan", local.suffix])), 0, 40)
      name_unique = substr(join("-", compact([local.standard_prefix, "appsvcplan", local.suffix_unique])), 0, 40)
      min_length  = 1
      max_length  = 40
    }
    application_gateway = {
      name        = substr(join("-", compact([local.standard_prefix, "agw", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.standard_prefix, "agw", local.suffix_unique])), 0, 80)
      min_length  = 1
      max_length  = 80
    }
    application_insights = {
      name        = substr(join("-", compact([local.standard_prefix, "appi", local.suffix])), 0, 260)
      name_unique = substr(join("-", compact([local.standard_prefix, "appi", local.suffix_unique])), 0, 260)
      min_length  = 10
      max_length  = 260
    }
    cosmosdb_account = {
      name        = substr(join("-", compact([local.standard_prefix, "cosmos", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.standard_prefix, "cosmos", local.suffix_unique])), 0, 63)
      min_length  = 1
      max_length  = 63
    }
    data_factory = {
      name        = substr(join("-", compact([local.standard_prefix, "df", local.suffix])), 0, 60)
      name_unique = substr(join("-", compact([local.standard_prefix, "df", local.suffix_unique])), 0, 60)
      min_length  = 3
      max_length  = 63
    }
    data_bricks = {
      name        = substr(join("-", compact([local.standard_prefix, "databricks", local.suffix])), 0, 60)
      name_unique = substr(join("-", compact([local.standard_prefix, "databricks", local.suffix_unique])), 0, 60)
      min_length  = 3
      max_length  = 64
    }
    function_app = {
      name        = substr(join("-", compact([local.standard_prefix, "fapp", local.suffix])), 0, 60)
      name_unique = substr(join("-", compact([local.standard_prefix, "fapp", local.suffix_unique])), 0, 60)
      min_length  = 2
      max_length  = 60
    }
    managed_private_endpoint = {
      name        = substr(join("-", compact(["mpe", "ws", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact(["mpe", "ws", local.suffix_unique])), 0, 80)
      min_length  = 1
      max_length  = 80
    }
    managed_sql_instance = {
      name        = substr(join("-", compact([local.standard_prefix, "msqlinstance", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.standard_prefix, "msqlinstance", local.suffix_unique])), 0, 63)
      min_length  = 1
      max_length  = 63
    }
    mssql_server = {
      name        = substr(join("-", compact([local.standard_prefix, "sql", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.standard_prefix, "sql", local.suffix_unique])), 0, 63)
      min_length  = 1
      max_length  = 63
    }
    private_endpoint = {
      name        = substr(join("-", compact([local.standard_prefix, "pe", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.standard_prefix, "pe", local.suffix_unique])), 0, 80)
      min_length  = 1
      max_length  = 80
    }
    private_dns_zone_group_name = {
      name        = substr(join("-", compact([local.standard_prefix, "pdzgn", local.suffix])), 0, 60)
      name_unique = substr(join("-", compact([local.standard_prefix, "pdzgn", local.suffix_unique])), 0, 60)
      min_length  = 1
      max_length  = 60
    }
    private_service_connection = {
      name        = substr(join("-", compact([local.standard_prefix, "psc", local.suffix])), 0, 80)
      name_unique = substr(join("-", compact([local.standard_prefix, "psc", local.suffix_unique])), 0, 80)
      min_length  = 1
      max_length  = 80
    }
    private_link_hub = {
      name        = substr(join("", compact([var.organization-code, "plh", local.sasuffix])), 0, 45)
      name_unique = substr(join("", compact([var.organization-code, "plh", local.sasuffix_unique])), 0, 45)
      min_length  = 1
      max_length  = 45
    }
    redis_cache = {
      name        = substr(join("-", compact([local.standard_prefix, "redis", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.standard_prefix, "redis", local.suffix_unique])), 0, 63)
      min_length  = 1
      max_length  = 63
    }
    resource_group = {
      name        = substr(join("-", compact([local.standard_prefix, "rsg", local.suffix])), 0, 90)
      name_unique = substr(join("-", compact([local.standard_prefix, "rsg", local.suffix_unique])), 0, 90)
      min_length  = 1
      max_length  = 90
    }
    storage_account = {
      name        = substr(join("", compact([var.organization-code, "sa", local.sasuffix])), 0, 24)
      name_unique = substr(join("", compact([var.organization-code, "sa", local.sasuffix_unique])), 0, 24)
      min_length  = 3
      max_length  = 24
    }
    storage_container = {
      name        = substr(join("-", compact(["sact", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact(["sact", local.suffix_unique])), 0, 63)
      min_length  = 3
      max_length  = 63
    }
    virtual_machine_linux = {
      name        = substr(join("", compact([var.organization-code, var.subscription-code, var.environment-code, "lvm", random_id.vm_unique_number.dec])), 0, 15)
      name_unique = "test_unique"
      min_length  = 1
      max_length  = 15
    }
    virtual_machine_windows = {
      name        = substr(join("", compact([var.organization-code, var.subscription-code, var.environment-code, "wvm", random_id.vm_unique_number.dec])), 0, 15)
      name_unique = "test_unique"
      min_length  = 1
      max_length  = 15
    }
    vm_scaleset = {
      name       = substr(join("", compact([var.organization-code, var.subscription-code, var.environment-code, "vmss", local.suffix])), 0, 64)
      min_length = 1
      max_length = 64
    }
    analysis_services = {
      name        = substr(join("", compact([var.organization-code, "analysis", local.analysissuffix])), 0, 63)
      name_unique = substr(join("", compact([var.organization-code, "analysis", local.analysissuffix_unique])), 0, 63)
      min_length  = 3
      max_length  = 63
    }
    mysql_server = {
      name        = substr(join("-", compact([local.standard_prefix, "mysql", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.standard_prefix, "mysql", local.suffix_unique])), 0, 63)
      min_length  = 1
      max_length  = 63
    }
    postgresql_server = {
      name        = substr(join("-", compact([local.standard_prefix, "postgresql", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.standard_prefix, "postgresql", local.suffix_unique])), 0, 63)
      min_length  = 3
      max_length  = 63
    }
    mariadb_server = {
      name        = substr(join("-", compact([local.standard_prefix, "mariadb", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.standard_prefix, "mariadb", local.suffix_unique])), 0, 63)
      min_length  = 3
      max_length  = 63
    }
    keyvault = {
      name        = substr(join("-", compact([local.standard_prefix, "kvt", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.standard_prefix, "kvt", local.suffix_unique])), 0, 63)
      min_length  = 3
      max_length  = 63
    }
    loadbalancer = {
      name        = substr(join("-", compact([local.standard_prefix, "lb", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.standard_prefix, "lb", local.suffix_unique])), 0, 63)
    }
    kubernetes_service = {
      name        = substr(join("-", compact([local.standard_prefix, "kvt", local.suffix])), 0, 63)
      name_unique = substr(join("-", compact([local.standard_prefix, "kvt", local.suffix_unique])), 0, 63)
      min_length  = 3
      max_length  = 63
    }
    container_registry = {
      name        = substr(join("-", compact([local.standard_prefix, "acr", local.suffix])), 0, 63)
      name_unique = substr(join("", compact([var.organization-code, "acr", local.acrsuffix_unique])), 0, 63)
      min_length  = 3
      max_length  = 63
    }
  }
}
