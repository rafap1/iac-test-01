pipeline {
    agent { label 'agent' }
    
    environment {
        GOOGLE_APPLICATION_CREDENTIALS = credentials('gcp-terraform-sa')
        TF_IN_AUTOMATION = 'true'
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/rafap1/iac-test-01.git'
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