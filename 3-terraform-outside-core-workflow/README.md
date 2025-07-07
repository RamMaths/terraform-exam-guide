## Terraform taint

The terraform `taint` command allows for you to manually mark a resource for recreation. The `taint` command informs Terraform that a particular resource needs to be rebuilt even if there has been no configuration change for that resource. Terraform represents this by marking the resource as *"tainted"* in the Terraform state, in which case Terraform will propose to replace it in the next plan you create. 

You can also `untaint` a resource by using the terraform untaint command.

```sh
terraform untaint aws_instance.web_server
```

This informs Terraform that this resource does not need to be rebuilt upon the next terraform apply.

## Using `-replace`

As of Terraform `v0.15.2` and later the `taint` command is deprecated, because there are better alternatives available. If your intent is to force replacement of a particular object even though there are no configuration changes that would require it, it is recommended to use the `-replace` option with terraform apply in place of the depcreated `taint` command.

## Terraform import

What if there are existing resources that we'd also like to manage with Terraform?

Enter `terrform import`. With minimal coding effort, we can add our resources to our configuration and bring them into state. You must have a destination resource to store state against. The import command is comprised of four parts.

- `terraform` to call our binary
- `import` to specify the action to take
- `aws_instance.aws_linux` (resource ID) to specify the resource in our config file (main.tf) that this resource corresponds to
- `i-0bfff5070c5fb87b6` (instance ID) to specify the real-world resource (in this case, an AWS EC2 instance) to import into state

> **Note**: The resource name and unique identifier of that resource are unique to each configuration.

## Terraform workspaces

Workspaces is a Terraform feature that allows us to organize infrastructure by environments and variables in a single directory.

Terraform is based on a stateful architecture and therefore stores state about your managed infrastructure and configuration. This state is used by Terraform to map real world resources to your configuration, keep track of metadata, and to improve performance for large infrastructures.

The persistent data stored in the state belongs to a Terraform workspace. Initially the backend has only one workspace, called “default”, and thus there is only one Terraform state associated with that configuration.

## Debugging terraform

Terraform has detailed logs which can be enabled by setting the `TF_LOG` environment variable to any value. This will cause detailed logs to appear on stderr. You can set `TF_LOG` to one of the log levels TRACE, DEBUG, INFO, WARN or ERROR to change the verbosity of the logs, with TRACE being the most verbose.
