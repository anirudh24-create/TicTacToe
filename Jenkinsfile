pipeline {
    agent any

    environment {
        IMAGE_NAME = "flask-docker-app"
        CONTAINER_NAME = "flask-docker-container"
        APP_PORT = "8080"
        HOST_PORT = "8081"
    }

    stages {
        stage('Check Docker') {
            steps {
                sh 'which docker || echo "Docker not found"'
                sh 'docker --version || echo "Docker command failed"'
                sh 'echo $PATH'
            }
        }
        
        stage('Clone Repository') {
            steps {
                cleanWs()  // Clean up any previous workspace
                script {
                    try {
                        git branch: 'main', url: 'https://github.com/anirudh24-create/TicTacToe.git'
                    } catch (Exception e) {
                        echo "Git clone failed: ${e.getMessage()}"
                        currentBuild.result = 'FAILURE'
                        return
                    }
                }
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
                    try {
                        sh "docker rm -f ${CONTAINER_NAME} || true"
                    } catch (Exception e) {
                        echo "Error stopping container: ${e.getMessage()}"
                    }
                }
            }
        }

        stage('Run New Container') {
            steps {
                script {
                    try {
                        docker.image("${IMAGE_NAME}").run(
                            "-d -p ${HOST_PORT}:${APP_PORT} --name ${CONTAINER_NAME}"
                        )
                    } catch (Exception e) {
                        echo "Error running container: ${e.getMessage()}"
                        currentBuild.result = 'FAILURE'
                        return
                    }
                }
            }
        }
    }
}
