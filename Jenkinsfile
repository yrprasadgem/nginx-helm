pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Checkout the source code from your Git repository
                // Use the appropriate Git credentials and repository URL
                git credentialsId: 'your-credentials', url: 'https://github.com/nginx-helm.git'
            }
        }

        stage('Build') {
            steps {
                // Run 'make plan' command using Makefile
                sh 'make plan'
            }
        }

        stage('Deploy') {
            steps {
                // Run 'make install' command using Makefile
                sh 'make install'
            }
        }
    }
}
