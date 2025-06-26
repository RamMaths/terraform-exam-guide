# Terraform Basics

## Providers

Providers define individual units of infrastructure, for example compute instances or private networks, as resources. You can compose resources from different providers into reusable Terraform configurations called modules, and manage them with a consistent language and workflow.

To deploy infrastructure with Terraform:

- Scope - Identify the infrastructure for your project.
- Author - Write the configuration for your infrastructure.
- Initialize - Install the plugins Terraform needs to manage the infrastructure.
- Plan - Preview the changes Terraform will make to match your configuration.
- Apply - Make the planned changes.

## Terraform lifecycle

![Lifecycle](../assets/lifecycle.png)

## Change Automation

**What is change management?** is the procedure that will be followed when resources are modify and applied via configuration script.

**What is change Automation?** a way of automatically creating consistent, systematic, and predictable way of managing change request via controls and policies.

Terraform uses Change Automation in the form of <mark>Execution Plans</mark> and <mark>Resources graphs</mark> to apply and review complex <mark>changesets</mark>

## Execution plans

Is a manual review of what will add, change or destroy before you apply changes eg. terraform apply. You can visualize an execution plan using the `terraform graph` command. Terraform will output a GraphViz file.

```sh
terraform graph | dot -Tsvg > graph.svg
```

## Terraform Core and Terraform Plugins

- Core: Uses remote procedure calls (RPC) to communicate with Terraform Plugins
- Plugins: expose an implementation for a specific service, or provisioner

![CorePlugins](../assets/corevsplugins.png)

## Terraform syntaxis

### Terraform Block

The `terraform {}` block conatins Terraform settings, including the required providers. Terraform will use to provision your infrastructure. For each provider, the `source` attribute defines an optional hostname, a namespace, and a provider type

You can also set a version constraint for each provider defined in the required_providers block. The `version` attribute is optional, but we recommend using it to constrain the provider version so that Terraform does not install a version of the provider that does not work with your configuration.

### Providers

The `provider` block configures the specified provider, in this case `aws`. A provider is a plugin that Terraform uses to create and manage your resources. You can use multiple provider blocks in your terraform configuration to manage resources from different providers. You can even use different providers together.

### Resources

Use `resource` blocks to define components of your infrastructure. A resource might be a physical or virtual component such as an EC2 instance, or it can be a logical resource such as a Heroku application.

Resource blocks have two strings before the block: the resource type and the resource name. Together the resoruce type and name form a unique ID fo the resource.
