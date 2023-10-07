pipeline {
    agent {
        label 'node'
    }
    stages {
        stage('Create Calculator Image and Push it to Local Registry'){
            agent {
                label 'master'
            }
            steps {
                echo "Building docker image"
                sh '''
                original_pwd=$(pwd -P)
                docker build -t node:5000/calculator:v$BUILD_NUMBER .
                docker push node:5000/calculator:v$BUILD_NUMBER
                sh '''
            }
        }
        stage('Deploy Calculator App to Node Server') {
            agent {
                label 'node'
            }
            steps {
                script {
                    // Pulling Images from Local Registry
                    sh "docker pull node:5000/calculator:v$BUILD_NUMBER"
                    def containerName = 'calculator'
                    def isContainerRunning = sh(script: "docker ps -q -f name=${containerName}", returnStatus: true) == 0

                    if (isContainerRunning) {
                        echo "Stopping and removing the '${containerName}' container..."
                        // Stop the container
                        sh "docker stop ${containerName}"
                        // Remove the container
                        sh "docker rm ${containerName}"
                        echo "Container '${containerName}' has been stopped and removed."
                    } else {
                        echo "Container '${containerName}' is not running."
                    }
                    // Create new container
                    sh "docker container run -itd --name calculator -p 3000:3000 node:5000/calculator:v$BUILD_NUMBER"
                }
            }
        }
    }
    post {
        always {
            mail to: 'maharjan.utsavv@gmail.com',
            subject: "Job '${JOB_NAME}' (${BUILD_NUMBER}) is waiting for input",
            body: "Please go to ${BUILD_URL} and verify the build"
        }
        success {
            mail bcc: 'utssav70@gmail.com', body: """Hi Team,

Build #$BUILD_NUMBER is successful, please go through the url

$BUILD_URL

and verify the details.

Regards,
DevOps Team""", cc: '', from: '', replyTo: '', subject: 'BUILD SUCCESS NOTIFICATION', to: 'maharjan.utsavv@gmail.com'
        }
        failure {
            mail bcc: 'utssav70@gmail.com', body: """Hi Team,

Build #$BUILD_NUMBER is unsuccessful, please go through the url

$BUILD_URL

and verify the details.

Regards,
DevOps Team""", cc: 'utssav70@gmail.com', from: '', replyTo: '', subject: 'BUILD FAILED NOTIFICATION', to: 'maharjan.utsavv@gmail.com'
        }
    }
}
