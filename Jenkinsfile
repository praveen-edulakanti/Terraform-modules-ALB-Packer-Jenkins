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
                sh 'pwd'
                sh 'ls -l'
				sh 'sudo terraform init -var-file="${Environment}.tfvars"'
				sh 'sudo terraform workspace select ${Environment}'
				sh 'sudo terraform plan -var-file="${Environment}.tfvars" -out=${Environment}tfplanout -input=true'
            }
        }
        stage('Terraform Apply') { 
            steps {
             sh 'sudo terraform workspace select ${Environment}'
             sh 'sudo terraform apply -auto-approve "${Environment}"tfplanout'
            }
        }
        stage('Application Job') { 
            steps {
               sh 'echo ${WORKSPACE}'
               sh 'pwd'
               sh 'sudo rm -rf "${WORKSPACE}"/user'
               sh 'sudo rm -rf "${WORKSPACE}"/dashboard'
               sh 'sudo rm -rf "${WORKSPACE}"/user.*.*'
               sh 'sudo rm -rf "${WORKSPACE}"/dashboard.*.*'
               sh 'sudo mkdir "${WORKSPACE}"/user'
               sh 'sudo mkdir "${WORKSPACE}"/dashboard'
               sh 'sudo git clone https://github.com/praveen-edulakanti/user.git "${WORKSPACE}"/user'
               sh 'sudo git clone https://github.com/praveen-edulakanti/dashboard.git "${WORKSPACE}"/dashboard'
               sh 'sudo zip -r user.zip user/'
               sh 'sudo zip -r dashboard.zip dashboard/'
               sh 'ls -l'
               sh 'aws s3 cp "${WORKSPACE}"/user.zip s3://"${S3BucketName}"/code_repo/'
               sh 'aws s3 cp "${WORKSPACE}"/dashboard.zip s3://"${S3BucketName}"/code_repo/'
               sh 'sudo rm -rf "${WORKSPACE}"/user.*.*'
               sh 'sudo rm -rf "${WORKSPACE}"/dashboard.*.*'
            }
        }
        stage('Application Deployment') {
            agent { label 'master'}
            environment {
             PrivateInstIPAddr1 = sh(script: 'sudo terraform output PrivateInstIPAddr1', , returnStdout: true).trim()
             PrivateInstIPAddr2 = sh(script: 'sudo terraform output PrivateInstIPAddr2', , returnStdout: true).trim()
            }
            steps {
             sh 'echo "${PrivateInstIPAddr1}"'
             sh 'echo "${PrivateInstIPAddr2}"'
             sh 'echo "${S3BucketName}"'
             sh 'sudo /bin/sh ./application_deployment.sh "${PrivateInstIPAddr1}" "${PrivateInstIPAddr2}" "${S3BucketName}" "${WORKSPACE}"'
            }
        }    
    }
}