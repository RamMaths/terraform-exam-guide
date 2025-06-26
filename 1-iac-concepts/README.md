# IaC

IaC allows you to build, change, and manage your infrastructure in a safe, consistent, and repeatable way by defining resource configurations that you can version, reuse, and share.

Terraform is HashiCorp's infrastructure as code tool. It lets you define resources and infrastructure in human-readable, declarative configuration files, and manages your infrastructure's lifecycle. Using Terraform has several advantages over manually managing your infrastructure:

- Terraform can manage infrastructure on multiple cloud platforms.
- The human-readable configuration language helps you write infrastructure code quickly.
- Terraform's state allows you to track resource changes throughout your deployments.
- You can commit your configurations to version control to safely collaborate on infrastructure.

# What is infrastructure lifecycle?

A number of clearly defined and distinct work phases which are used by DevOps engineers to *plan*, *design*, *build*, *test*, *deliver*, *mantain* and *retire* cloud infrastructure.

## What is Day 0, Day 1 and Day 2?

- Day 0 - Plan and Design
- Day 1 - Develop and Iterate
- Day 2 - Go live and mantain

> Days do not literally mean a 24 hour days and is just a broad way of defining where a infrastructure project would be.

## Advantages

- **Reliability**: Iac makes changes idempotent, consistent, repeatable and predictable.
- **Manageability**: Enable mutation via code 

## Non-Idempotent vs Idempotent
- **Idempotent**: Applying the same configuration multiple times produces the same result (e.g., Terraform, Ansible). Safe to rerun.
- **Non-Idempotent**: Repeated execution may cause unintended changes or failures (e.g., some scripts or imperative commands). Risk of duplication or errors.

## Provisioning vs Deployment vs Orchestration

### Provisioning

To prepare a server with systems, data and software, and make it ready for network operation. Using configuration management tools like puppet, ansible, bashscripts, chef

### Deployment

Is the act of delivering a version of your application to run a provisioned server. Deployment could be performed via AWS CodePipeline, Harness, Jenkins, Github Actions.

### Orchestration

## Configuration drift

When provisioned infrastructure has <mark>an unexpected configuration change</mark> due to:
 - team members manually adjusting confiugration options
 - malicious actors
 - side effects from APIs, SDK or CLIs

Is the act of coordinating multiple systems or services.

## Immutable infrastructure guarantee

Terraform encourages you towards an Immutable infrastructure architect so you get the following guarantees

- Cloud resource failures
- Application failure
- Time to deploy
- Worst case scenario
    - Accidental deletion
    - Compromised malicious actor
    - Need to change region
- No guarantee of 1 to 1: Every time Cloud-init runs post deploy there is no guarantee its one-to-one with your other VMs
