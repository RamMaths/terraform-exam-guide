## Terraform State Default Local Backend

The location and method of operation of Terraform’s state is determined by the Terraform backend. By default Terraform uses a local backend, where state information is stored and acted upon locally within the working directory in a local file named terraform.tfstate.

The terrafrom backend end configuration for a given working directory is specified in the Terraform configuration block. If we want to be explicit about which backend Terraform should use it would cause no harm to add the following to our Terraform configuration block within the `terraform.tf` file.

## Terraform State Locking

Terraform’s local state is stored on disk as JSON, and that file must always be up to date before a person or process runs Terraform. If the state is out of sync, the wrong operation might occur, causing unexpected results. If supported, the state backend will “lock” to prevent concurrent modifications which could cause corruption.

Not all Terraform backends support locking - Terraform’s documentation identifies which backends support this functionality. Some common Terraform backends that support locking include:

- Remote Backend (Terraform Enterprise, Terraform Cloud)
- AWS S3 Backend (with DynamoDB)
- Google Cloud Storage Backend
- Azure Storage Backend

Obviously locking is an important feature of a Terraform backend in which there are multiple people collaborating on a single state file.

## Terraform S3 Standard Backend

The local backend stores state as a local file on disk, but other backend types store state in a remote service of some kind, which allows multiple people to access it. Accessing state in a remote service generally requires some kind of access credentials since state data contains extremely sensitive information.

```terraform
terraform {
  backend "s3"{
    bucket = "prueba-terraform-rmata-001"
    key = "prod/aws_infra"
    region = "us-east-1"
    profile = "ramses"
  }
}
```

Once the configuration is complete, you can verify authentication to the S3 backend by first removing infrastructure that has already been deployed with a `terraform destroy` and performing a `terraform init`.
