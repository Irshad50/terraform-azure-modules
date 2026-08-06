variable "lb" {
  type        = map(any)
  description = "Map of Load Balancer configurations"
}

variable "lb_nic_associations" {
  type        = map(any)
  description = "Map of NIC to LB Backend Pool associations"
  default     = {}
}
