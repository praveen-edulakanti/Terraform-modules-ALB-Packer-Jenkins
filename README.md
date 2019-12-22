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
    terraform plan -var-file="QA.tfvars"

    terraform workspace new Staging
    terraform workspace select Staging
    terraform plan -var-file="Staging.tfvars"
8) Calling Terraform from Jenkins Application.    


