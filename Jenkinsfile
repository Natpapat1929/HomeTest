pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/develop']], 
                         userRemoteConfigs: [[url: 'https://github.com/Natpapat1929/HomeTest.git']]])
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("robot-test", "--file Dockerfile .")
                }
            }
        }
        
        stage('Run Tests') {
            steps {
                script {
                    sh 'docker exec robot-test robot --outputdir /opt/robotframework/reports /opt/robotframework/tests/script.robot'
                }
            }
        }
        
        stage('Publish Results') {
            steps {
                // เก็บผลลัพธ์การทดสอบ
                archiveArtifacts artifacts: 'results/*', allowEmptyArchive: true
                
                // Publish Robot Framework report
                robot outputPath: 'results'
                
                // Publish HTML report
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
            // ทำความสะอาด
            sh 'docker rmi -f robot-test || true'
        }
    }
}