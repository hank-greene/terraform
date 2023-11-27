
deploy the drupal site via terraform

terraform and terragrunt
env0.com/blog/terragrunt
https://terragrunt.gruntwork.io/docs/getting-started/quick-start/

install https://github.com/gruntwork-io/terragrunt/releases

u2@u2:~/Dev/02-tf/terraform$ sudo snap install terragrunt terragrunt 0+git.ae675d6 from dt9394 (terraform-snap) installed

u2@u2:~/Dev/02-tf/terraform$ terragrunt DESCRIPTION: terragrunt - Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules, remote state, and locking. For documentation, see https://github.com/gruntwork-io/terragrunt/.

USAGE: terragrunt

COMMANDS: plan-all Display the plans of a 'stack' by running 'terragrunt plan' in each subfolder apply-all Apply a 'stack' by running 'terragrunt apply' in each subfolder output-all Display the outputs of a 'stack' by running 'terragrunt output' in each subfolder destroy-all Destroy a 'stack' by running 'terragrunt destroy' in each subfolder

               Terragrunt forwards all other commands directly to Terraform
GLOBAL OPTIONS: terragrunt-config Path to the Terragrunt config file. Default is terraform.tfvars. terragrunt-tfpath Path to the Terraform binary. Default is terraform (on PATH). terragrunt-non-interactive Assume "yes" for all prompts. terragrunt-working-dir The path to the Terraform templates. Default is current directory. terragrunt-source Download Terraform configurations from the specified source into a temporary folder, and run Terraform in that temporary folder. terragrunt-source-update Delete the contents of the temporary folder to clear out any old, cached source code before downloading new source code into it. terragrunt-ignore-dependency-errors *-all commands continue processing components even if a dependency fails.

VERSION:

AUTHOR(S): Gruntwork <www.gruntwork.io>

spacelift.io/blog/terraform-output

terraform "design" tradeoffs getbetterdevops.io/terraform-create-infrastructure-in-multiple-environments 1. Separated directories Pros: Environments are separated and identifiable More granularity: customized environment layers Less chance of applying a configuration in a bad environment Cons: Need to duplicate a piece of file structure to create a new environment Several directory levels in a project 2. Workspaces Pros: Scalability with repeatable environments Simplicity Cons: More possible to make errors by selecting a wrong workspace The customization of an environment layer is less obvious

stackoverflow.com/questions/66024950/how-to-organize-modules-for-multiple-environments 1. Separated definitions for separated resources Pros: Hard to check if all modules are in sync Complicated CI Complicated directory Cons: 2. Monolith infrastructure Pros: Cons:

codurance.com/publications/2020/04/28/terraform-with-multiple-environments

About
deploy the drupal site via terraform

Resources
 Readme
License
 MIT license
 Activity
Stars
 0 stars
Watchers
 1 watching
Forks
 0 forks
Releases
No releases published
Create a new release
Packages
No packages published
Publish your first package
Languages
HCL
100.0%
Footer
© 2023 GitHub, Inc.
Footer navigation
Terms
Privacy
Security
Status
Docs
Contact GitHub
Pricing
API
Training
Blog
About


