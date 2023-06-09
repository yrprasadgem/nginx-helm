pipeline {
    agent any

    stages {
        stage('Code Checkout') {
            steps {
                checkout([
                    $class: 'GitSCM', 
                    branches: [[name: '*/main']], 
                    userRemoteConfigs: [[url: 'https://github.com/nginx-helm.git']]
                ])
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
