variable "digitalocean_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive   = true
}

variable "name_prefix" {
  description = "Prefix used for resource names"
  type        = string
}

variable "region" {
  description = "DigitalOcean region"
  type        = string
}

variable "droplet_image" {
  description = "DigitalOcean Droplet image"
  type        = string
}

variable "droplet_size" {
  description = "DigitalOcean Droplet size"
  type        = string
}

variable "project_environment" {
  description = "Project environment"
  type        = string
}

variable "vpc_ip_range" {
  description = "VPC IP range. Null means DigitalOcean chooses it automatically."
  type        = string
  default     = null
}