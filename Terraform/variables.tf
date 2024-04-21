variable "aws_region" {
  description = "The AWS region your resources will be deployed"
  default = "us-east-1"
}

variable "instance_type" {
  description = "El tipo de instancia EC2 a utilizar."
  default     = "t2.medium"
}

variable "instance_ami" {
  description = "La ID de la AMI de Ubuntu Server 22.04 en la región especificada."
  default     = "ami-080e1f13689e07408"  # Reemplaza con la ID correcta de la AMI
}
# --------------------------------------------------------------------------------------

variable "ssh_public_key_path" {
  description = "La ruta al archivo de clave pública SSH."
  default     = "~/.ssh/id_rsa.pub"  # Reemplaza con la ruta correcta de tu clave pública SSH
}

variable "key_pair_path" {
  description = "pin.pem"
  default = "/keys/pin.pem"
} 


variable "key_pair_name" {
  description = "KeyName"
  default     = "pin"
}

variable "file_name" {
  description = "KeyName"
  default     = "pinLocal"
}


