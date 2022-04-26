variable "name" {
  type = string
  description = "Specifies the name of the Resource Group."
}
variable "location" {
  type = string
  description = "Specifies the location of the Resource Group."
}
variable "tags" {
  type = map(string)
  description = "A mapping of tags to assign to the resource."
}
