# terraform-azurerm-security-center
Terraform module to create an Azure Dns.
#
## Description
An Azure Domain Name System (DNS) is a solution that uses a global network of name servers to provide quick responces to DNS queries.provides unified security management and threat protection for data centers in the cloud. 

This module will create a DNS including:an A record, AAAA record, CAA record, CName record, MX record, NS record, PTR record, SRV record, txt record and a DNS zone.

## Module Example Use
```hcl
module "DNS" {
  source = "../../module/terraform-azurerm-DNS"

  rgroup_name                     = "example-resources"
  resource_group_location         = "West Europe"

  dns_zone_name                   = "mydomain.com"
  dns_zone_resource_group_name    = azurerm_resource_group.example.name
      record{
        dns_zone_email                  = example@example.com
        dns_zone_host_name              = ns1-03.azure-dns.com
      }
 }

  dns_a_record_name               = "test"
  dns_a_zone_name                 = azurerm_dns_zone.example.name
  dns_a_resource_group            = azurerm_resource_group.example.name
  dns_a_ttl                       = "300"

  dns_aaaa_name                   = "test"
  var.dns_aaaa_zone_name          = azurerm_dns_zone.example.name
  dns_aaaa_resource_group         = azurerm_resource_group.example.name
  dns_aaaa_ttl                    = 300

  dns_caa_name                    = "test"
  dns_caa_zone_name               = azurerm_dns_zone.example.name
  dns_caa_resource_group_name     = azurerm_resource_group.example.name
  dns_caa_ttl                     = 300

    record{
      flags_caa                   = 0
      dns_caa_tag                 = "issue"
      dns_caa_value               = mail_to_example.com
  }

  dns_cname_record_name           = "test"
  dns_cname_record_zone_name      = azurerm_dns_zone.example.name
  dns_cname_record_group_name     = azurerm_resource_group.example.name
  dns_cname_record_ttl            = 300
  dns_cname_record_record         = "contoso.com"

  DNS_mx_zone_name                = azurerm_dns_zone.example.name
  DNS_mx_resource_group_name      = azurerm_resource_group.example.name
  DNS_mx_ttl                      = 300
 record{
      DNS_mx_preference           = 10
      DNS_mx_exchange             = "mail2.contoso.com"
  }

  DNS_ns_name                     = "example"
  DNS_ns_zone_name                = azurerm_dns_zone.example.name
  DNS_ns_resource_group_name      = azurerm_resource_group.example.name
  DNS_ns_ttl                      = 300
  DNS_ns_records                  = ["ns1.contoso.com", "ns2.contoso.com"]

  DNS_ptr_name                    = "test"
  DNS_ptr_zone_name               = azurerm_dns_zone.example.name
  DNS_ptr_resource_group          = azurerm_resource_group.example.name
  DNS_ptr_ttl                     = 300
  DNS_ptr_records                 = ["yourdomain.com"]

  DNS_srv_name                    = "test"
  DNS_srv_zone_name               = azurerm_dns_zone.example.name
  DNS_srv_resource_group_name     = azurerm_resource_group.example.name
  DNS_srv_ttl                     = 300
     record{
      DNS_srv_priority            = 1
      DNS_srv_weight              = 5
      DNS_srv_port                = 8080
      DNS_srv_target              = "target1.com"
  }

  DNS_txt_name                    = "test"
  DNS_txt_zone_name               = azurerm_dns_zone.example.name
  DNS_txt_resource_group_name     = azurerm_resource_group.example.name
  DNS_txt_ttl                     = 300
     record{
      DNS_txt_value              = "google-site-authenticator"
  }

```


## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_dns_a_record.az_dns_a_record](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) | resource |
| [azurerm_dns_aaaa_record.az_dns_aaaa_record](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_aaaa_record) | resource |
| [azurerm_dns_caa_record.az_dns_caa_record](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_caa_record) | resource |
| [azurerm_dns_cname_record.az_dns_cname_record](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_cname_record) | resource |
| [azurerm_dns_mx_record.az_dns_mx_record](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_mx_record) | resource |
| [azurerm_dns_ns_record.az_dns_ns_record](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_ptr_record.az_dns_ptr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_ptr_record) | resource |
| [azurerm_dns_srv_record.az_dns_srv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_srv_record) | resource |
| [azurerm_dns_txt_record.az_dns_txt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_txt_record) | resource |
| [azurerm_dns_zone.az_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_zone) | resource |
| [azurerm_resource_group.az_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_DNS_mx_exchange"></a> [DNS\_mx\_exchange](#input\_DNS\_mx\_exchange) | The mail server responsible for the domain covered by the MX record. | `string` | n/a | yes |
| <a name="input_DNS_mx_preference"></a> [DNS\_mx\_preference](#input\_DNS\_mx\_preference) | String representing the preference value of the MX records. Records with lower preference value take priority. | `string` | n/a | yes |
| <a name="input_DNS_mx_record"></a> [DNS\_mx\_record](#input\_DNS\_mx\_record) | A list of values that make up the MX record. Each record block supports fields documented below. | `string` | n/a | yes |
| <a name="input_DNS_mx_record_name"></a> [DNS\_mx\_record\_name](#input\_DNS\_mx\_record\_name) | the name of the dnsmx record | `string` | `"@"` | no |
| <a name="input_DNS_mx_resource_group_name"></a> [DNS\_mx\_resource\_group\_name](#input\_DNS\_mx\_resource\_group\_name) | Specifies the resource group where the resource exists. Changing this forces a new resource to be created | `string` | n/a | yes |
| <a name="input_DNS_mx_tags"></a> [DNS\_mx\_tags](#input\_DNS\_mx\_tags) | A mapping of tags to assign to the resource. | `list (string)` | `""` | no |
| <a name="input_DNS_mx_ttl"></a> [DNS\_mx\_ttl](#input\_DNS\_mx\_ttl) | DNS record time to live | `string` | n/a | yes |
| <a name="input_DNS_mx_zone_name"></a> [DNS\_mx\_zone\_name](#input\_DNS\_mx\_zone\_name) | the dns zone where the parent esource exists | `string` | n/a | yes |
| <a name="input_DNS_ns_environment"></a> [DNS\_ns\_environment](#input\_DNS\_ns\_environment) | a mapping of tags to assign to the resource | `string` | n/a | yes |
| <a name="input_DNS_ns_name"></a> [DNS\_ns\_name](#input\_DNS\_ns\_name) | the name of the DNS ns record | `string` | n/a | yes |
| <a name="input_DNS_ns_records"></a> [DNS\_ns\_records](#input\_DNS\_ns\_records) | a list of values that make up NS record | `string` | n/a | yes |
| <a name="input_DNS_ns_resource_group_name"></a> [DNS\_ns\_resource\_group\_name](#input\_DNS\_ns\_resource\_group\_name) | Specifies the resource group where the resource exists. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_DNS_ns_ttl"></a> [DNS\_ns\_ttl](#input\_DNS\_ns\_ttl) | time to live of DNS record in seconds | `string` | n/a | yes |
| <a name="input_DNS_ns_zone_name"></a> [DNS\_ns\_zone\_name](#input\_DNS\_ns\_zone\_name) | specifies the DNS zone where the DNS parent resource exists | `string` | n/a | yes |
| <a name="input_DNS_ptr_name"></a> [DNS\_ptr\_name](#input\_DNS\_ptr\_name) | the name of the ptr record | `string` | n/a | yes |
| <a name="input_DNS_ptr_records"></a> [DNS\_ptr\_records](#input\_DNS\_ptr\_records) | list of domain names | `string` | n/a | yes |
| <a name="input_DNS_ptr_resource_group"></a> [DNS\_ptr\_resource\_group](#input\_DNS\_ptr\_resource\_group) | Specifies the resource group where the resource exists. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_DNS_ptr_tags"></a> [DNS\_ptr\_tags](#input\_DNS\_ptr\_tags) | a mapping of tags to assign to the resource | `list (string)` | `""` | no |
| <a name="input_DNS_ptr_ttl"></a> [DNS\_ptr\_ttl](#input\_DNS\_ptr\_ttl) | time to live of the DNS in seconds | `string` | n/a | yes |
| <a name="input_DNS_ptr_zone_name"></a> [DNS\_ptr\_zone\_name](#input\_DNS\_ptr\_zone\_name) | Specifies the DNS Zone where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_DNS_srv_name"></a> [DNS\_srv\_name](#input\_DNS\_srv\_name) | srv name | `string` | n/a | yes |
| <a name="input_DNS_srv_port"></a> [DNS\_srv\_port](#input\_DNS\_srv\_port) | port the service is listening on | `string` | n/a | yes |
| <a name="input_DNS_srv_priority"></a> [DNS\_srv\_priority](#input\_DNS\_srv\_priority) | priority of SRV record | `string` | n/a | yes |
| <a name="input_DNS_srv_resource_group_name"></a> [DNS\_srv\_resource\_group\_name](#input\_DNS\_srv\_resource\_group\_name) | Specifies the resource group where the resource exists. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_DNS_srv_tags"></a> [DNS\_srv\_tags](#input\_DNS\_srv\_tags) | a mapping of tags to assign to the resource | `list (string)` | `""` | no |
| <a name="input_DNS_srv_target"></a> [DNS\_srv\_target](#input\_DNS\_srv\_target) | FQDN of the service. | `string` | n/a | yes |
| <a name="input_DNS_srv_ttl"></a> [DNS\_srv\_ttl](#input\_DNS\_srv\_ttl) | time to live | `string` | n/a | yes |
| <a name="input_DNS_srv_weight"></a> [DNS\_srv\_weight](#input\_DNS\_srv\_weight) | Weight of the SRV record | `string` | n/a | yes |
| <a name="input_DNS_srv_zone_name"></a> [DNS\_srv\_zone\_name](#input\_DNS\_srv\_zone\_name) | specifies the dns zone where the parent resource exists | `string` | n/a | yes |
| <a name="input_DNS_txt_name"></a> [DNS\_txt\_name](#input\_DNS\_txt\_name) | the name of the DNS TXT record | `string` | n/a | yes |
| <a name="input_DNS_txt_resource_group_name"></a> [DNS\_txt\_resource\_group\_name](#input\_DNS\_txt\_resource\_group\_name) | Specifies the resource group where the resource exists. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_DNS_txt_tags"></a> [DNS\_txt\_tags](#input\_DNS\_txt\_tags) | A mapping of tags to assign to the resource. | `list (string)` | `""` | no |
| <a name="input_DNS_txt_ttl"></a> [DNS\_txt\_ttl](#input\_DNS\_txt\_ttl) | The Time To Live (TTL) of the DNS record in seconds. | `string` | n/a | yes |
| <a name="input_DNS_txt_value"></a> [DNS\_txt\_value](#input\_DNS\_txt\_value) | The value of the record. Max length: 1024 characters | `string` | n/a | yes |
| <a name="input_DNS_txt_zone_name"></a> [DNS\_txt\_zone\_name](#input\_DNS\_txt\_zone\_name) | Specifies the DNS Zone where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_dns_a_record_name"></a> [dns\_a\_record\_name](#input\_dns\_a\_record\_name) | dns a record name. | `string` | n/a | yes |
| <a name="input_dns_a_records"></a> [dns\_a\_records](#input\_dns\_a\_records) | List of IPv4 Addresses. Conflicts with target\_resource\_id.either records OR target\_resource\_id must be specified, but not both. | `list(string)` | `""` | no |
| <a name="input_dns_a_resource_group"></a> [dns\_a\_resource\_group](#input\_dns\_a\_resource\_group) | dns a record resource group name | `string` | n/a | yes |
| <a name="input_dns_a_tags"></a> [dns\_a\_tags](#input\_dns\_a\_tags) | A mapping of tags to assign to the resource.either records OR target\_resource\_id must be specified, but not both. | `list(string)` | `""` | no |
| <a name="input_dns_a_target_resource_id"></a> [dns\_a\_target\_resource\_id](#input\_dns\_a\_target\_resource\_id) | The Azure resource id of the target object. Conflicts with records.Specifies the resource group where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created.either records OR target\_resource\_id must be specified, but not both. | `string` | `""` | no |
| <a name="input_dns_a_ttl"></a> [dns\_a\_ttl](#input\_dns\_a\_ttl) | dns a record ttl value | `string` | n/a | yes |
| <a name="input_dns_a_zone_name"></a> [dns\_a\_zone\_name](#input\_dns\_a\_zone\_name) | the dns a record zone . | `string` | n/a | yes |
| <a name="input_dns_aaaa_name"></a> [dns\_aaaa\_name](#input\_dns\_aaaa\_name) | dns aaaa name | `string` | n/a | yes |
| <a name="input_dns_aaaa_records"></a> [dns\_aaaa\_records](#input\_dns\_aaaa\_records) | List of IPv6 Addresses. Conflicts with target\_resource\_id.either records OR target\_resource\_id must be specified, but not both. | `list (string)` | `""` | no |
| <a name="input_dns_aaaa_resource_group"></a> [dns\_aaaa\_resource\_group](#input\_dns\_aaaa\_resource\_group) | dns aaaa resource group name | `string` | n/a | yes |
| <a name="input_dns_aaaa_tags"></a> [dns\_aaaa\_tags](#input\_dns\_aaaa\_tags) | A mapping of tags to assign to the resource. | `list (string)` | `""` | no |
| <a name="input_dns_aaaa_target_resource_id"></a> [dns\_aaaa\_target\_resource\_id](#input\_dns\_aaaa\_target\_resource\_id) | The Azure resource id of the target object. Conflicts with records.either records OR target\_resource\_id must be specified, but not both. | `string` | `""` | no |
| <a name="input_dns_aaaa_ttl"></a> [dns\_aaaa\_ttl](#input\_dns\_aaaa\_ttl) | dns aaaa ttl | `string` | n/a | yes |
| <a name="input_dns_aaaa_zone_name"></a> [dns\_aaaa\_zone\_name](#input\_dns\_aaaa\_zone\_name) | dns aaaa zone name | `string` | n/a | yes |
| <a name="input_dns_caa_name"></a> [dns\_caa\_name](#input\_dns\_caa\_name) | Dns caa name | `string` | n/a | yes |
| <a name="input_dns_caa_resource_group_name"></a> [dns\_caa\_resource\_group\_name](#input\_dns\_caa\_resource\_group\_name) | Specifies the resource group where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_dns_caa_tag"></a> [dns\_caa\_tag](#input\_dns\_caa\_tag) | A property tag, options are issue, issuewild and iodef.. | `string` | n/a | yes |
| <a name="input_dns_caa_tags"></a> [dns\_caa\_tags](#input\_dns\_caa\_tags) | A mapping of tags to assign to the resource. | `list(string)` | `""` | no |
| <a name="input_dns_caa_ttl"></a> [dns\_caa\_ttl](#input\_dns\_caa\_ttl) | time to live of the DNS record. | `string` | n/a | yes |
| <a name="input_dns_caa_value"></a> [dns\_caa\_value](#input\_dns\_caa\_value) | A property value such as a registrar domain. | `string` | n/a | yes |
| <a name="input_dns_caa_zone_name"></a> [dns\_caa\_zone\_name](#input\_dns\_caa\_zone\_name) | Specifies the DNS Zone where the resource exists. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_dns_cname_record_group_name"></a> [dns\_cname\_record\_group\_name](#input\_dns\_cname\_record\_group\_name) | Specifies the resource group where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_dns_cname_record_name"></a> [dns\_cname\_record\_name](#input\_dns\_cname\_record\_name) | The name of the DNS CNAME Record. | `string` | n/a | yes |
| <a name="input_dns_cname_record_record"></a> [dns\_cname\_record\_record](#input\_dns\_cname\_record\_record) | The target of the CNAME.either record OR target\_resource\_id must be specified, but not both. | `string` | n/a | yes |
| <a name="input_dns_cname_record_tags"></a> [dns\_cname\_record\_tags](#input\_dns\_cname\_record\_tags) | A mapping of tags to assign to the resource. | `list (string)` | `""` | no |
| <a name="input_dns_cname_record_target_resource_id"></a> [dns\_cname\_record\_target\_resource\_id](#input\_dns\_cname\_record\_target\_resource\_id) | The Azure resource id of the target object. Conflicts with records. either record OR target\_resource\_id must be specified, but not both. | `string` | `""` | no |
| <a name="input_dns_cname_record_ttl"></a> [dns\_cname\_record\_ttl](#input\_dns\_cname\_record\_ttl) | The Time To Live (TTL) of the DNS record in seconds. | `string` | n/a | yes |
| <a name="input_dns_cname_record_zone_name"></a> [dns\_cname\_record\_zone\_name](#input\_dns\_cname\_record\_zone\_name) | Specifies the DNS Zone where the resource exists. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_dns_zone_email"></a> [dns\_zone\_email](#input\_dns\_zone\_email) | The email contact for the SOA record. | `string` | n/a | yes |
| <a name="input_dns_zone_expire_time"></a> [dns\_zone\_expire\_time](#input\_dns\_zone\_expire\_time) | The expire time for the SOA record. | `number` | `"2419200"` | no |
| <a name="input_dns_zone_host_name"></a> [dns\_zone\_host\_name](#input\_dns\_zone\_host\_name) | The domain name of the authoritative name server for the SOA record. | `string` | `"ns1-03.azure-dns.com."` | no |
| <a name="input_dns_zone_minimum_ttl"></a> [dns\_zone\_minimum\_ttl](#input\_dns\_zone\_minimum\_ttl) | The minimum Time To Live for the SOA record. By convention, it is used to determine the negative caching duration. | `number` | `"300"` | no |
| <a name="input_dns_zone_name"></a> [dns\_zone\_name](#input\_dns\_zone\_name) | DNS zone name.If you are going to be using the Private DNS Zone with a Private Endpoint the name of the Private DNS Zone must follow the Private DNS Zone name schema in the product documentation in order for the two resources to be connected successfully. | `string` | n/a | yes |
| <a name="input_dns_zone_refresh_time"></a> [dns\_zone\_refresh\_time](#input\_dns\_zone\_refresh\_time) | The refresh time for the SOA record. | `number` | `"3600"` | no |
| <a name="input_dns_zone_resource_group_name"></a> [dns\_zone\_resource\_group\_name](#input\_dns\_zone\_resource\_group\_name) | Specifies the resource group where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_dns_zone_retry_time"></a> [dns\_zone\_retry\_time](#input\_dns\_zone\_retry\_time) | The retry time for the SOA record. | `number` | `"300"` | no |
| <a name="input_dns_zone_serial_number"></a> [dns\_zone\_serial\_number](#input\_dns\_zone\_serial\_number) | The serial number for the SOA record. | `number` | `"1"` | no |
| <a name="input_dns_zone_soa_record"></a> [dns\_zone\_soa\_record](#input\_dns\_zone\_soa\_record) | An soa\_record block as defined below. Changing this forces a new resource to be created. | `string` | `""` | no |
| <a name="input_dns_zone_tags"></a> [dns\_zone\_tags](#input\_dns\_zone\_tags) | A mapping of tags to assign to the Record Set. | `list (string)` | `""` | no |
| <a name="input_dns_zone_ttl"></a> [dns\_zone\_ttl](#input\_dns\_zone\_ttl) | The Time To Live of the SOA Record in seconds. | `number` | `"3600"` | no |
| <a name="input_flags_caa"></a> [flags\_caa](#input\_flags\_caa) | dns aaaa ip address | `string` | n/a | yes |
| <a name="input_resource_group_location"></a> [resource\_group\_location](#input\_resource\_group\_location) | Specifies the resource group location | `string` | n/a | yes |
| <a name="input_rgroup_name"></a> [rgroup\_name](#input\_rgroup\_name) | The name of the DNS A Record. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_DNS_MX_record_FQDN"></a> [DNS\_MX\_record\_FQDN](#output\_DNS\_MX\_record\_FQDN) | The FQDN of the DNS MX Record. |
| <a name="output_DNS_MX_record_id"></a> [DNS\_MX\_record\_id](#output\_DNS\_MX\_record\_id) | The DNS MX Record ID. |
| <a name="output_DNS_NS_record_FQDN"></a> [DNS\_NS\_record\_FQDN](#output\_DNS\_NS\_record\_FQDN) | The FQDN of the DNS NS Record. |
| <a name="output_DNS_NS_record_id"></a> [DNS\_NS\_record\_id](#output\_DNS\_NS\_record\_id) | The DNS NS Record ID. |
| <a name="output_DNS_PTR_FQDN"></a> [DNS\_PTR\_FQDN](#output\_DNS\_PTR\_FQDN) | The FQDN of the DNS PTR Record. |
| <a name="output_DNS_PTR_record_id"></a> [DNS\_PTR\_record\_id](#output\_DNS\_PTR\_record\_id) | The DNS PTR Record ID. |
| <a name="output_DNS_SRV_FQDN"></a> [DNS\_SRV\_FQDN](#output\_DNS\_SRV\_FQDN) | The FQDN of the DNS SRV Record. |
| <a name="output_DNS_SRV_record_id"></a> [DNS\_SRV\_record\_id](#output\_DNS\_SRV\_record\_id) | The DNS SRV Record ID. |
| <a name="output_DNS_TXT_FQDN"></a> [DNS\_TXT\_FQDN](#output\_DNS\_TXT\_FQDN) | The FQDN of the DNS TXT Record. |
| <a name="output_DNS_TXT_record_id"></a> [DNS\_TXT\_record\_id](#output\_DNS\_TXT\_record\_id) | The DNS TXT Record ID. |
| <a name="output_DNS_a_record_FQDN"></a> [DNS\_a\_record\_FQDN](#output\_DNS\_a\_record\_FQDN) | The FQDN of the DNS A Record. |
| <a name="output_DNS_a_record_id"></a> [DNS\_a\_record\_id](#output\_DNS\_a\_record\_id) | The DNS A Record ID |
| <a name="output_DNS_aaaa_record_FQDN"></a> [DNS\_aaaa\_record\_FQDN](#output\_DNS\_aaaa\_record\_FQDN) | The FQDN of the DNS AAAA Record.. |
| <a name="output_DNS_aaaa_record_id"></a> [DNS\_aaaa\_record\_id](#output\_DNS\_aaaa\_record\_id) | The DNS AAAA Record ID. |
| <a name="output_DNS_caa_record_FQDN"></a> [DNS\_caa\_record\_FQDN](#output\_DNS\_caa\_record\_FQDN) | The FQDN of the DNS CAA Record. |
| <a name="output_DNS_caa_record_id"></a> [DNS\_caa\_record\_id](#output\_DNS\_caa\_record\_id) | The DNS CAA Record ID. |
| <a name="output_DNS_cname_record_FQDN"></a> [DNS\_cname\_record\_FQDN](#output\_DNS\_cname\_record\_FQDN) | The FQDN of the DNS CName Record. |
| <a name="output_DNS_cname_record_id"></a> [DNS\_cname\_record\_id](#output\_DNS\_cname\_record\_id) | The DNS CName Record ID. |
| <a name="output_DNS_zone_id"></a> [DNS\_zone\_id](#output\_DNS\_zone\_id) | id of the DNS Zone |
| <a name="output_DNS_zone_max_number_of_record_sets"></a> [DNS\_zone\_max\_number\_of\_record\_sets](#output\_DNS\_zone\_max\_number\_of\_record\_sets) | Maximum number of Records in the zone. |
| <a name="output_DNS_zone_name_servers"></a> [DNS\_zone\_name\_servers](#output\_DNS\_zone\_name\_servers) | A list of values that make up the NS record for the zone. |
| <a name="output_DNS_zone_number_of_record_sets"></a> [DNS\_zone\_number\_of\_record\_sets](#output\_DNS\_zone\_number\_of\_record\_sets) | The number of records already in the zone. |
| <a name="output_DNS_zone_tags"></a> [DNS\_zone\_tags](#output\_DNS\_zone\_tags) | A mapping of tags to assign to the EventHub Namespace. |
