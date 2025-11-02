pipeline {
    agent { label 'ssh-agent' }
    
    parameters {
        string(name: 'TF_VERSION', defaultValue: '1.13.4', description: 'Terraform version to use')
    }
    
    environment {
        GOOGLE_APPLICATION_CREDENTIALS = credentials('gcp-terraform-sa')
        TF_IN_AUTOMATION = 'true'
        TENV_AUTO_INSTALL = 'true'
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/rafap1/iac-test-01.git'
            }
        }
        
        stage('Setup Terraform') {
            steps {
                sh "tenv terraform use ${params.TF_VERSION}"
            }
        }
        
        stage('Terraform Format Check') {
            steps {
                sh 'terraform fmt -check -recursive'
            }
        }
        
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
        
        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }
        
        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=tfplan'
                archiveArtifacts artifacts: 'tfplan', fingerprint: true
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
    }
}