variable "credentials" {
  description = "GCP cred"
  default     = "../../../my_cred.json"
}

variable "project" {
  description = "Project name"
  default     = ""
}

variable "region" {
  description = "Project location"
  default     = ""
}

variable "location" {
  description = "BQ location"
  default     = "US"
}

variable "bq_dataset_name" {
  description = "BQ dataset"
  default     = "demo"
}

variable "gcs_bucket_name" {
  description = "Storage name"
  default     = ""

}

variable "gcs_storage_class" {
  description = "Storage class"
  default     = "STANDARD"
}
