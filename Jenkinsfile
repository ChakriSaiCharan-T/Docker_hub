pipeline {
    agent any 
    environment {
        DOCKERHUB_CREDENTIALS = credentials('docker-hub')
    }
    stages { 
        stage('Build docker image') {
            steps {  
                script {
                    try {
                        sh 'docker build -t rakesh/sampleapp:$BUILD_NUMBER .'
                    } catch (Exception e) {
                        error("Docker build failed: ${e}")
                    }
                }
            }
        }
        stage('Login to Docker Hub') {
            steps {
                script {
                    try {
                        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                    } catch (Exception e) {
                        error("Docker login failed: ${e}")
                    }
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    try {
                        sh 'docker push rakesh/sampleapp:$BUILD_NUMBER'
                    } catch (Exception e) {
                        error("Docker push failed: ${e}")
                    }
                }
            }
        }
    }
    post {
        always {
            sh 'docker logout'
            
        }
    }
}
