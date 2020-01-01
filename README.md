#
1) Creating 2 AMI's using Packer.
2) 1 AMI - Installation of Apache, PHP7.2 in Ubuntu(ami-0123b531fc646552f (64-bit x86)) FileName: packer-ubuntu-apache2-php.json
3) 1 AMI - Installation of Jenkins, Terraform in Ubuntu(ami-0123b531fc646552f (64-bit x86)) FileName: packer-ubuntu-jenkins-terraform.json
4) Terraform implementing in modules with Application Load Balancer using Existing Recent AMI.
5) Creating Backend file to store terraform.tfstate files in S3 Bucket.
6) Two Variable Files QA.tfvars, Staging.tfvars
7) Creating two workspace names with below command and executing: 
    terraform init
    terraform workspace new QA
    terraform workspace select QA
    terraform plan -var-file="QA.tfvars" -input=true
    terraform apply -var-file="QA.tfvars" -auto-approve
    terraform destroy -var-file="QA.tfvars" -auto-approve

    terraform workspace new Staging
    terraform workspace select Staging
    terraform plan -var-file="Staging.tfvars" -input=true
    terraform apply -var-file="Staging.tfvars" -auto-approve
    terraform destroy -var-file="Staging.tfvars" -auto-approve
8) Calling Terraform from Jenkins Application is the Main Goal.
9) aws configure command used to setup aws_access_key_id, aws_secret_access_key in the Environment variables.
10) In Jenkins: This project is parameterized with option, Choice Parameter used to show list of QA, Staging
11)Build after other projects are built used to call other jobs sequence order i.e Terraform Plan, Terraform Apply, Application Job(Store Code in S3), Application Deployment(deploy code in ec2 instance)
12) Jenkins Jobs shell script is able in jenkins folder in the repository.


