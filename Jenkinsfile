pipeline {
    agent any
    
    environment {
        CONTAINER_NAME = 'robot-test'
    }
    
    stages {

        stage('Checkout') {
            steps {
                git branch: 'develop', url: 'https://github.com/Natpapat1929/HomeTest.git'
            }
        }

        stage('Prepare Environment') {
            steps {
                script {
                    // ตรวจสอบว่ามี container ทำงานอยู่หรือไม่
                    def containerRunning = sh(script: "docker inspect -f '{{.State.Running}}' ${env.CONTAINER_NAME} || true", returnStdout: true).trim()
                    
                    if (containerRunning != 'true') {
                        // ถ้าไม่มี container ทำงานอยู่ ให้สร้างใหม่
                        sh "docker run -d --name ${env.CONTAINER_NAME} -v ${WORKSPACE}:/robot robot-test sleep infinity"
                    }
                }
            }
        }
        
        stage('Run Tests') {
            steps {
                sh """
                docker exec ${env.CONTAINER_NAME} robot --outputdir results script.robot
                """
            }
        }
        
        stage('Publish Results') {
            steps {
                // เก็บผลลัพธ์
                archiveArtifacts artifacts: 'results/**/*', allowEmptyArchive: true
                
                // Publish Robot Framework results (ต้องติดตั้ง plugin "Robot Framework")
                robot outputPath: 'results'
                
                // Publish HTML report (optional)
                publishHTML(target: [
                    allowMissing: false,
                    alwaysLinkToLastBuild: false,
                    keepAll: true,
                    reportDir: 'results',
                    reportFiles: 'report.html',
                    reportName: 'Robot Framework Report'
                ])
            }
        }
    }
    
    post {
        always {
            sh "docker stop ${env.CONTAINER_NAME} && docker rm ${env.CONTAINER_NAME}"
        }
    }
}