variable "vm" {
  type        = map(any)
  description = "Virtual Machine map"
}

variable "password" {
  type        = string
  sensitive   = true
  description = "VM Admin Password"
}