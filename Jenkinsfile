pipeline {
    agent { label 'ssh-agent' }
    
    parameters {
        string(name: 'TF_VERSION', defaultValue: '1.13.4', description: 'Terraform version to use')
    }
    
    environment {
        GOOGLE_APPLICATION_CREDENTIALS = credentials('gcp-terraform-sa')
        TF_IN_AUTOMATION = 'true'
        TENV_AUTO_INSTALL = 'true'
        APPLY_APPROVED = 'false'
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
                sh 'terraform show -no-color tfplan > tfplan.txt'
                archiveArtifacts artifacts: 'tfplan,tfplan.txt', fingerprint: true
            }
        }
        stage('Approve Apply') {
            steps {
                script {
                    try {
                        timeout(time: 5, unit: 'MINUTES') {
                            input message: 'Apply Terraform changes?', ok: 'Apply',
                                  submitterParameter: 'APPROVER'
                        }
                        env.APPLY_APPROVED = 'true'
                        echo "Apply approved by: ${env.APPROVER}"
                    } catch (Exception e) {
                        env.APPLY_APPROVED = 'false'
                        echo "Apply not approved (timeout or abort): ${e.getMessage()}"
                    }
                }
            }
        }
        
        stage('Terraform Apply') {
            when {
                expression { env.APPLY_APPROVED == 'true' }
            }
            steps {
                sh 'terraform apply tfplan'
            }
        }
        
        stage('Cleanup on Skip') {
            when {
                expression { env.APPLY_APPROVED == 'false' }
            }
            steps {
                echo 'Apply was skipped - performing cleanup'
                sh 'rm -f tfplan'
                echo 'Plan file removed, no changes applied'
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
    }
}