# Read, Generate and Modify Configuration

## Local Values

A local value assigns a name to an expression, so you can use it multiple times within a configuration without repeating it. The expressions in local values are not limited to literal constants; they can also refrence other values in the configuration in order to transform or combine them, including variables, resource attributes, or other local values.

You can use local values to simplify your Terraform configuration and avoid repetition. <mark> If overused they can also make a configuration hard to read by future mantainers is by hiding the actual values used.

Use local values only in moderation, in situation where a single value or result is used in many places and that value is likely to be changed in the future.

## Variables

In Terraform OSS, there are 3 ways that we can set the value of a variable. The first way is setting an environment variable before running `terraform plan` or `terraform apply` command. To set a value using an environmnet varible, we will use the `TF_VAR` prefix, which is followed by the name of the variable. For example, to set the value of a variable named "variables_sub_cidr", we would need to set an environmnet variable called `TF_VAR_variables_sub_cidr` to the desired value.

```sh
export TF_VAR_variables_sub_cidr
```

Another way we can set the value of a variable is within a tfvars file. This is a special file that Terraform can use to retrieve specific values of variables without requiring the operator (you!) to modify the variables file or set environment variables.

Finally, the last way that you can set the value for a Terraform variable is to simply set the value only the command line when running a terraform plan or terraform apply using a flag.

```sh
terraform plan -var variables_sub_az="us-east-1e" -var variables_sub_cidr="10.0.205.0/24"
```

## Outputs

Outputs allow customization of Terraform’s output during a Terraform apply. Outputs define useful values that will be highlighted to the user when Terraform is executed. Examples of values commonly retrieved using outputs include IP addresses, usernames, and generated keys

As we saw earlier the `output` command will print those values after a `terraform apply` we can also use `terraform output` command to find specific values.

```sh
terraform output
terraform output public_ip
ping $(terraform output -raw public_dns)
```

Terraform provides us with the sensitive argument to use in the output block. This allows you to mark the value as sensitive (hence the name) and prevent the value from showing in the CLI output. It does not, however, prevent the value from being listed in the state file or anything like that.

```tf
output "ec2_instance_arn" {
    value = aws_instance.web_server.arn
    sensitive = true
}
```

## Variable validation and supression

We may want to validate and possibly suppress and sensitive information defined within our variables.

```tf
variable "cloud" {
    type = string
    validation {
        condition = contains(["aws", "azure", "gcp", "vmware"], lower(var.cloud))
        error_message = "You must use an approved cloud."
    }
    validation {
        condition = lower(var.cloud) == var.cloud
        error_message = "The cloud name must not have capital letters."
    }
}

variable "no_caps" {
    type = string
    validation {
        condition = lower(var.no_caps) == var.no_caps
        error_message = "Value must be in all lower case."
    }
}

variable "character_limit" {
    type = string
    validation {
        condition = length(var.character_limit) == 3
        error_message = "This variable must contain only 3 characters."
    }
}

variable "ip_address" {
    type = string
    validation {
        condition = can(regex("^(?:[0-9]{1,3}\\.){3}[0-9]{1,3}$", var.ip_address))
        error_message = "Must be an IP address of the form X.X.X.X."
    }
}
```

## Suppress sensitive information

Terraform allows us to mark variables as sensitive and suppress that information.

```tf
variable "phone_number" {
    type = string
    sensitive = true
    default = "867-5309"
}
```

## Secure Secrets in Terraform Code

Never put secret values, like password or access tokens, in tf. files or other files that are checked into source control. If you store secrets in plain text, you are giving the bad actors countless ways to access sensitive data. Ramifications for placing secrests in plain text include:

- Anyone who has access to the version control system has access to that secret.
- Every computer that has access to the version control system keeps a copy of that secret.
- Every piece of software you run has access to that secret.
- No way to audit or revoke access to that secret.

The first line of defense here is to mark the variable as sensitive so Terraform won't output the value in the Terraform CLI. Remember that this value will still show up in the Terraform state file.

Another way to protect secrets is to simply keep plain text secrets out of your code by taking adbantage of Terraform's native support for reading environment variables. By setting the `TF_VAR_<name>` environment variable, Terraform will use that value rather than having to add that directly to your code.
