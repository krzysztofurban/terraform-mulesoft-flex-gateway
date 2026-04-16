variable "cplane" {
  default = "us"
  description = "The control plane to use for the Anypoint Platform. Valid values are: us, eu, and ap."
}

variable "root_org" {
  default = ""
  description = "organization GUID for the root organization. This is required to create a new organization and to manage existing organizations. You can find this value in the URL when you are in the Anypoint Platform, it is the value after /org/ and before /env/."
}

variable "env_id" {
  default = ""
  description = "environment GUID for the environment you want to manage. This is required to manage resources in an existing environment. You can find this value in the URL when you are in the Anypoint Platform, it is the value after /env/ and before /applications/."
}

variable "client_id" {
  default = ""
  description = "client_id"
}

variable "client_secret" {
  default = ""
  description = "client_secret"
}