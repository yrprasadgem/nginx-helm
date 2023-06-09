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
        stage('Mini Plan') {
            steps {
                script {
                    def environment = 'mini'
                    def release = 'ingress-nginx-internal'

                    // Job: lint
                    if (env.BUILD_REASON == 'PullRequest') {
                        stage('Helm Chart lint') {
                            steps {
                                checkout scm
                                sh "make lint environment=${environment}"
                            }
                        }
                    }

                    // Job: plan
                    stage('Helm Chart plan') {
                        steps {
                            checkout scm
                            sh 'make helm_repo_add'  // Continue on error
                            sh "make plan repo=ingress-nginx release=${release} environment=${environment}"
                        }
                    }
                }
            }
        }

        stage('Mini Install') {
            when {
                allOf {
                    not {
                        expression {
                            return env.BUILD_REASON == 'Manual'
                        }
                    }
                    branch 'master'
                    allOf {
                        stage('Mini Plan')
                        expression {
                            return currentBuild.result == 'SUCCESS'
                        }
                    }
                }
            }
            steps {
                script {
                    def environment = 'mini'
                    def release = 'ingress-nginx-internal'

                    // Deployment: install
                    stage('Helm Chart install') {
                        environment {
                            ENVIRONMENT = environment
                        }
                        steps {
                            checkout scm
                            sh "make install_helm repo=ingress-nginx release=${release} environment=${environment}"
                        }
                    }
                }
            }
        }
    }
}
