variable "mesh_id" {
  description = "The Istio mesh ID"
  type        = string

  nullable = false
}

variable "cluster1" {
  description = "The configuration for the first cluster"
  type = object({
    name                = string
    resource_group_name = string
  })

  nullable = false
}

variable "cluster2" {
  description = "The configuration for second first cluster"
  type = object({
    name                = string
    resource_group_name = string
  })

  nullable = false
}
