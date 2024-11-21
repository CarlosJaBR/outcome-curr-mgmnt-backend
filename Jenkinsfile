pipeline {
    agent any
    environment {
        IMAGE_NAME = 'outcome-curr-mgmt-backend'
        DOCKER_PORT = '9090:8080'
    }
    stages {
        stage('Docker Image Build') {
            steps {
                script {
                    echo 'Docker info'
                    bat 'docker info'
                    echo 'Build Docker image'
                    docker.build("${IMAGE_NAME}")
                }
            }
        }

        stage('Run Unit Tests') {
            steps {
                script {
                    echo 'Execute unit tests'
                    docker.image("${IMAGE_NAME}").inside {
                        bat 'mvn test'
                    }
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
