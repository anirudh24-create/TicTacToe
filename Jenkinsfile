pipeline {
    agent any

    environment {
        IMAGE_NAME = "flask-docker-app"
        CONTAINER_NAME = "flask-docker-container"
        APP_PORT = "8080"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/anirudh24-create/TicTacToe.git'
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
                        "-d -p ${APP_PORT}:${APP_PORT} --name ${CONTAINER_NAME}"
                    )
                }
            }
        }
    }
}
