pipeline {
    agent none
    environment {
        DOCKER_PORT = '9090:8080'
    }
    triggers {
        githubPush()
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
                jacoco execPattern: '**/target/*.exec', classPattern: '**/target/classes', sourcePattern: '**/src/main/java'
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

        stage('Run Smoke Tests') {
            agent { label 'initial-node' }
            steps {
                script {
                    echo 'Running smoke tests...'
                    bat 'mvn verify -Dtest=SmokeTest'
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
