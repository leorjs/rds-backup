variable "instance_class" {
  default = "db.t3.micro"
}

variable "db_name" {
  default = "mydb"
}

variable "username" {
  default = "admin"
}

variable "password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "allocated_storage" {
  default = 20
}

variable "availability_zones" {
  description = "List of availability zones in the region"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b"]  # Ajusta según tu región
}

