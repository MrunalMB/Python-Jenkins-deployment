pipeline {
    agent any
    environment {
        DOCKER_IMAGE_NAME = "python-hello-world"
    }
    stages {
        // Stage 1: Clone Repository
        stage('Clone Repository') {
            steps {
                // This will automatically clone the repository to the Jenkins workspace
                git 'https://github.com/MrunalMB/Python-Jenkins-deployment' // Replace with your repo URL
            }
        }

        // Stage 2: Set Up Python Environment
        stage('Set Up Python Environment') {
            steps {
                script {
                    sh '''
                        python -m venv venv
                        . venv/bin/activate
                        pip install -r requirements.txt
                    '''
                }
            }
        }

        // Stage 3: Run the Application
        stage('Run Application') {
            steps {
                script {
                    sh '''
                        python app.py
                    '''
                }
            }
        }

        // Stage 4: Build Docker Image
        stage('Build Docker Image') {
            steps {
                script {
                    sh '''
                        docker build -t $DOCKER_IMAGE_NAME .
                    '''
                }
            }
        }

        // Stage 5: Push Docker Image to Docker Hub
        stage('Push Docker Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        sh '''
                            docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
                            docker tag $DOCKER_IMAGE_NAME $DOCKER_USERNAME/$DOCKER_IMAGE_NAME:latest
                            docker push $DOCKER_USERNAME/$DOCKER_IMAGE_NAME:latest
                        '''
                    }
                }
            }
        }
    }

    // Clean up workspace after the build
    post {
        always {
            cleanWs()
        }
    }
}
