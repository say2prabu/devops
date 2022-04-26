locals {
  app_insights = try(data.azurerm_application_insights.main.0, {})
  default_app_settings = var.application_insights_enabled ? {
    APPLICATION_INSIGHTS_IKEY                  = try(local.app_insights.instrumentation_key, "")
    APPINSIGHTS_INSTRUMENTATIONKEY             = try(local.app_insights.instrumentation_key, "")
    APPLICATIONINSIGHTS_CONNECTION_STRING      = try(local.app_insights.connection_string, "")
    ApplicationInsightsAgent_EXTENSION_VERSION = "~2"
  } : {}
}