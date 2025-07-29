pipeline {
    agent any

    environment {
        IMAGE_NAME = "flask-docker-app"
        CONTAINER_NAME = "flask-docker-container"
        APP_PORT = "8080"
        HOST_PORT = "8081"
    }

    stages {
        stage('Clean Workspace') {
            steps {
                cleanWs() 
            }
        }

        stage('Check Docker') {
            steps {
                sh 'which docker || echo "Docker not found"'
                sh 'docker --version || echo "Docker command failed"'
                sh 'echo $PATH'
            }
        }

        stage('Clone Repository') {
            steps {
                sh 'pwd'
                sh 'ls -al'
                git branch: 'main', url: 'https://github.com/anirudh24-create/TicTacToe.git'
                sh 'git status'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image with the specified image name
                    sh "docker build -t ${IMAGE_NAME} ."
                }
            }
        }

        stage('Stop Old Container') {
            steps {
                script {
                    // Stop and remove any existing container
                    sh "docker rm -f ${CONTAINER_NAME} || true"
                }
            }
        }

        stage('Run New Container') {
            steps {
                script {
                    // Run the new Docker container
                    sh "docker run -d -p ${HOST_PORT}:${APP_PORT} --name ${CONTAINER_NAME} ${IMAGE_NAME}"
                }
            }
        }
    }
}
