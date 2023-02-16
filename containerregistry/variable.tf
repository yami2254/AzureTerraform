variable "appservice" {
    type = map(object({
        name = string
    }))
  
}

variable "appservice_plan" {
    type = map(string)
}
