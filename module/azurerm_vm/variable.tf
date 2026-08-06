variable "vm" {

}
variable "password" {
  type      = string
  sensitive = true # Ye zaroori hai taaki console output mein password na dikhe
}