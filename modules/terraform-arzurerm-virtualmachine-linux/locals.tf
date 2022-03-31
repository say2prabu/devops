locals {
  concat_tags = merge ({AtosManaged = false}, var.tags)
}