variable "env" {
  description = "Environment name"
  type        = string
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "key_name" {
  description = "SSH Key Pair name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "length" {
  description = "Number of instances"
  type        = number
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "ami" {
  description = "Amazon Machine Image ID"
  type        = string
}

variable "volume_size" {
  description = "Size of the root volume in GB"
  type        = number
}

variable "volume_type" {
  description = "Type of the root volume (gp3, gp2, etc.)"
  type        = string
}

variable "encrypted" {
  description = "Whether the volume is encrypted"
  type        = bool
}

variable "delete_on_termination" {
  description = "Whether to delete the volume on instance termination"
  type        = bool
}

variable "eip" {
  description = "Assign Elastic IP"
  type        = bool
}

variable "load_balancer" {
  description = "Attach to load balancer"
  type        = bool
}

variable "ssh_ports" {
  description = "List of allowed SSH ports"
  type        = list(number)
}

variable "ssh_cidr_block" {
  description = "CIDR block allowed to access SSH"
  type        = list(string)
}

variable "web_ports" {
  description = "List of allowed web ports"
  type        = list(number)
}

variable "web_cidr_blocks" {
  description = "CIDR block allowed to access web ports"
  type        = list(string)
}

variable "iam_role" {
  description = "IAM role name"
  type        = string
}
