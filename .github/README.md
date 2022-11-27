# Provision Azure AKS using Terraform & Azure DevOps

## Step-01: Introduction
- Create GitHub Action to create AKS cluster using Terraform for Open Liberty App 
- Provision Test AKS Cluster


## Step-02: Workflows
### Under workflows you can find the github workflow action for the test environment
#### Inrastructure-test.yml
- Will run on push on master branch
- Using Composite actions -> More details https://docs.github.com/en/actions/creating-actions/creating-a-composite-action
- Consist of 3 jobs
    - terraform-plan
    - terraform-apply
        This job is using environment variable which has a mandatory approval
    - install OpenLiberty operator -> https://learn.microsoft.com/en-us/azure/aks/howto-deploy-java-liberty-app


## Step-03: Actions
### 01-Terraform plan
### tf-plan.tf/action.yaml
Composite action.(In Order the code to be reusable accross multiple environment the files are created in separate directory and input parameters are passed)
- Logins to Azure
- Initializes terraform
- Generates Terraform plan

### 02-Terraform Apply
### tf-apply/action.yaml
Composite action.(In Order the code to be reusable accross multiple environment the files are created in separate directory and input parameters are passed)
- Logins to Azure
- Initializes terraform
- Applies the plan to Azure (Creates resources)

### 03-Open Liberty Operator Installation
### install-open-liberty/action.yaml
Composite action.(In Order the code to be reusable accross multiple environment the files are created in separate directory and input parameters are passed)
- Logins to Azure
- Installs Open Liberty on AKS -> https://learn.microsoft.com/en-us/azure/aks/howto-deploy-java-liberty-app


