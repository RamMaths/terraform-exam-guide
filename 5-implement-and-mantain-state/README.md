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

## Standard Backends

The built in Terraform standard backends store state remotely and perform terraform operations locally via the command line interface.

### Enable Versioning on S3 Bucket

Enabling versioning on our terraform backend is important as it allows us to restore the previous version of state should we need to. The s3 backend supports versioning, so every revision of your state file is stored.

### Enable Encryption on S3 Bucket

It is also incredibly important to protect terraform state data as it can contain extremely sensitive information. Store Terraform state in a backend that supports encryption. Instead of storing your state in a local terraform.tfstate file. Many backends support encryption, so that instead of your state files being in plain text, they will always be encrypted, both in transit (e.g., via TLS) and on disk (e.g., via AES-256). The s3 backend supports encryption, which reduces worries about storing sensitive data in state files.

### Enable Locking for S3 Backend

The s3 backend stores Terraform state as a given key in a given bucket on Amazon S3 to allow everyone working with a given collection of infrastructure the ability to access the same state data. In order to prevent concurrent modifications which could cause corruption, we need to implement locking on the backend.

## Terraform State Migration

As your maturity and use of Terraform develops there may come a time when you need change the backend type you are using. Perhaps you are onboarding new employees and now need to centralize state. You might be part of a merger/acquistion where you need to onboard another organization’s Terraform code to your standard configuration. You may simply like to move from a standard backend to an enhanced backend to leverage some of those backend features. Luckily Terraform makes it relatively easy to change your state backend configuration and migrate the state between backends along with all of the data that the state file contains.

```sh
terraform validate
terraform init -migrate-state
```

## Terraform State Refresh

The terraform refresh command reads the current settings from all managed remote objects
found in Terraform state and updates the Terraform state to match. Refreshing state is the first step of the `terraform plan` process: read the current state of any already existing remote objects to make sure that the Terraform state is up-to-date. If you wish to only perform the first part of the `terraform plan` process you can execute the plan with a `-refresh-only`.

The terraform refresh command won’t modify your real remote objects, but it will modify the the Terraform state. You shouldn’t typically need to use this command, because Terraform automatically performs the same refreshing actions as a part of creating a plan in both the terraform plan and terraform apply commands. Once your infrastructure is deployed you can run a terraform refresh to read the current settings of objects that terraform is managing.

## Controlling state refresh

Automatically applying the effect of a refresh is risky, because if you have misconfigured credentials for one or more providers then the provider may be misled into thinking that all of the managed objects have been deleted, and thus remove all of the tracked objects without any confirmation prompt. This is is why the terraform refresh command has been deprecated.

Instead it is recommended to use the `-refresh-only` option to get the same effect as a `terraform refresh` but with the opportunity to review the the changes that Terraform has detected before committing them to the state. The first step of the terraform plan process is to read the current state of any already-existing remote objects to make sure that the Terraform state is up-to-date

Terraform’s Refresh-only mode goal is only to update the Terraform state and any root module output values to match changes made to remote objects outside of Terraform. This can be useful if you’ve intentionally changed one or more remote objects outside of the usual workflow (e.g. while responding to an incident) and you now need to reconcile Terraform’s records with those changes.

To update Terraform’s state with these items that were modified outside of the usual workflow run a `terraform apply` -refresh-only

Use the `terraform state` commands to show the state of an EC2 instance after a state refresh is applied.

If this is permanent change then you would need to update the object within Terraform’s configuration to reflect this change otherwise it will be reverted back during the next apply

The terraform `refresh` and `-refresh-only` are useful for being able to help detect and handle drift within an environment.
