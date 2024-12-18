pipeline {
    agent none
    environment {
        DOCKER_PORT = '9091:8080'
    }
    stages {

        stage('Run Unit Tests') {
            agent { label 'initial-node' }
            steps {
                script {
                    echo 'Executing unit tests...'
                    bat 'mvn test'
                }
            }
        }
        stage('Docker Image Build') {
            agent { label 'initial-node' }
            steps {
                script {
                    echo 'Docker info'
                    bat 'docker info'
                    echo 'Build Docker image'
                    bat 'docker build -t outcome-curr-mgmt-backend .'
                }
            }
        }

        stage('Deploy and Run App') {
            agent { label 'initial-node' }
            steps {
                script {
                    echo 'Run the app'
                    bat "docker run -d -p ${DOCKER_PORT} outcome-curr-mgmt-backend"
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
