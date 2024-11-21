pipeline {
    agent none
    environment {
        DOCKER_PORT = '9090:8080'
    }
    stages {
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

        stage('Run Unit Tests') {
            agent { label 'initial-node' }
            steps {
                script {
                    echo 'Execute unit tests'
                    bat 'mvn test'

                }
            }
        }

        stage('Deploy and Run App') {
            agent { label 'initial-node' }
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
