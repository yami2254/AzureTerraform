variable "managementgroup" {
  type = map(object({
    name = string
    child = list(string)
    # sec-layer = map(object({
    #   name = string
    #   child = list(string)
    # }))
  }))
}