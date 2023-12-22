variable "type_instance" {

  type        = string
  default     = "t2.micro"

}

variable "ebs_size" {

  type        = number
  default     = "30"

}

variable "my_public_subnet" {

  type        = string
  default     = "default"

}

variable "my_sg" {

  type        = string
  default     = "default"

}
variable "Ec2Module" {
  type = string
  default = "Ec2Module"
}
variable "eip_ec2" {
  type = string
  default = "default"
}
variable "pub-key-path" {
  type = string
  default = "default"
}
variable "priv-key-path" {
  type = string
  default = "default"
}
variable "file-path" {
  type = string
  default = "default"
}
variable "secure_key_name" {
  type = string
  default = "default"
}

variable "remoteCommande" {
  type = list(string)
  default = [ "apt update","echo test > test.txt"]
}
