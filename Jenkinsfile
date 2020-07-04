pipeline {
    agent any
    environment {
            PrivateInstIPAddr1 = ''
            PrivateInstIPAddr2 = ''
            S3BucketName = ""
    }
    stages {
        stage('CleanWorkspace') {
            steps {
                cleanWs()
            }
        }
        stage('Terraform Code Pull'){
           steps {
               git url: 'https://github.com/praveen-edulakanti/Terraform-modules-ALB-Packer-Jenkins.git'
           }
        }
        stage('Terraform Plan') { 
            steps {
               sh '''   
		   pwd
                   ls -l
		   sudo terraform init -var-file="${Environment}.tfvars"
		   sudo terraform workspace select ${Environment}
		   sudo terraform plan -var-file="${Environment}.tfvars" -out=${Environment}tfplanout -input=true
		  '''
            }
        }
        stage('Terraform Apply') { 
            steps {
             sh '''
		   sudo terraform workspace select ${Environment}
                   sudo terraform apply -auto-approve "${Environment}"tfplanout
		'''
            }
        }
        stage('Application Job') { 
            steps {
	       sh '''    
               	   echo ${WORKSPACE}
                   pwd
                   sudo rm -rf "${WORKSPACE}"/user
                   sudo rm -rf "${WORKSPACE}"/dashboard
                   sudo rm -rf "${WORKSPACE}"/user.*.*
                   sudo rm -rf "${WORKSPACE}"/dashboard.*.*
                   sudo mkdir "${WORKSPACE}"/user
                   sudo mkdir "${WORKSPACE}"/dashboard
                   sudo git clone https://github.com/praveen-edulakanti/user.git "${WORKSPACE}"/user
                   sudo git clone https://github.com/praveen-edulakanti/dashboard.git "${WORKSPACE}"/dashboard
                   sudo zip -r user.zip user/
                   sudo zip -r dashboard.zip dashboard/
                   ls -l
                   aws s3 cp "${WORKSPACE}"/user.zip s3://"${S3BucketName}"/code_repo/
                   aws s3 cp "${WORKSPACE}"/dashboard.zip s3://"${S3BucketName}"/code_repo/
                   sudo rm -rf "${WORKSPACE}"/user.*.*
               	   sudo rm -rf "${WORKSPACE}"/dashboard.*.*
	       '''
            }
        }
        stage('Application Deployment') {
            agent { label 'master'}
            environment {
             PrivateInstIPAddr1 = sh(script: 'sudo terraform output PrivateInstIPAddr1', , returnStdout: true).trim()
             PrivateInstIPAddr2 = sh(script: 'sudo terraform output PrivateInstIPAddr2', , returnStdout: true).trim()
            }
            steps {
             sh '''
	         echo "${PrivateInstIPAddr1}"
                 echo "${PrivateInstIPAddr2}"
                 echo "${S3BucketName}"
                 sudo /bin/sh ./application_deployment.sh "${PrivateInstIPAddr1}" "${PrivateInstIPAddr2}" "${S3BucketName}" "${WORKSPACE}"
	      '''
            }
        }    
    }
}
