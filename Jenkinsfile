pipeline {
    agent any
    environment {
        DOCKER_PORT = '9090:8080'
    }
    stages {
        stage('Docker Image Build') {
            steps {
                script {
                    echo 'Docker info'
                    sh 'docker info'
                    echo 'Build Docker image'
                    sh 'docker build -t outcome-curr-mgmt-backend .'
                }
            }
        }

        stage('Run Unit Tests') {
            steps {
                script {
                    echo 'Execute unit tests'
                    sh 'mvn test'

                }
            }
        }

        stage('Deploy and Run App') {
            steps {
                script {
                    echo 'Run the app'
                    docker.image("${IMAGE_NAME}").run("-p ${DOCKER_PORT}")
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
