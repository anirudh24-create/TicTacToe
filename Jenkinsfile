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
                cleanWs()  // Clean previous workspace to ensure a fresh start
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
                git branch: 'main', url: 'https://github.com/anirudh24-create/TicTacToe.git'
                sh 'git status'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}")
                }
            }
        }

        stage('Stop Old Container') {
            steps {
                script {
                    sh "docker rm -f ${CONTAINER_NAME} || true"
                }
            }
        }

        stage('Run New Container') {
            steps {
                script {
                    docker.image("${IMAGE_NAME}").run(
                        "-d -p ${HOST_PORT}:${APP_PORT} --name ${CONTAINER_NAME}"
                    )
                }
            }
        }
    }
}
