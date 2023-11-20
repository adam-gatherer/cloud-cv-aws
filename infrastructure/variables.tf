variable "cv_bucket_name" {
    description = "Bucket holding cv.gatherer.tech site."
    type = string
}

variable "global_tags" {
  description = "Tags applied to every resource applicable"
  type = map(string)
}

variable "domain" {
  description = "Domain for cv.gatherer.tech"
  type = string
}

variable "dns_zone_id" {
  description = "Zone ID for cv.gatherer.tech"
  type = string
}