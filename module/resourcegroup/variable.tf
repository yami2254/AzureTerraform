variable "resourcegroup" {
    type = map(object({
        name = string
    }))
  default = {
    "rg1" = {
      name = "rg1"
    }
  }
}

