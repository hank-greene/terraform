# terraform
deploy the drupal site via terraform

spacelift.io/blog/terraform-output

terraform "design" tradeoffs
getbetterdevops.io/terraform-create-infrastructure-in-multiple-environments
    1. Separated directories
        Pros:
            Environments are separated and identifiable
            More granularity: customized environment layers
            Less chance of applying a configuration in a bad environment
        Cons:
            Need to duplicate a piece of file structure to create a new environment
            Several directory levels in a project
    2. Workspaces
        Pros:
            Scalability with repeatable environments
            Simplicity
        Cons:
            More possible to make errors by selecting a wrong workspace
            The customization of an environment layer is less obvious


stackoverflow.com/questions/66024950/how-to-organize-modules-for-multiple-environments
    1. Separated definitions for separated resources
        Pros:
            Hard to check if all modules are in sync
            Complicated CI
            Complicated directory
        Cons:
    2. Monolith infrastructure
        Pros:
        Cons:


codurance.com/publications/2020/04/28/terraform-with-multiple-environments
