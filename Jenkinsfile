pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/develop']], userRemoteConfigs: [[url: 'https://github.com/Natpapat1929/HomeTest.git']]])
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    // รันคำสั่ง Robot Framework ใน Container ชื่อ robot-test
                    sh 'docker exec robot-test robot --outputdir /opt/robotframework/reports /opt/robotframework/tests/script.robot'
                }

                // เก็บผลลัพธ์การทดสอบ
                archiveArtifacts artifacts: 'results/log.html,results/output.xml,results/report.html', allowEmptyArchive: true

                // เผยแพร่รายงาน HTML
                publishHTML(target: [
                    allowMissing: false,
                    alwaysLinkToLastBuild: false,
                    keepAll: true,
                    reportDir: 'results',
                    reportFiles: 'log.html',
                    reportName: 'Robot Framework Report'
                ])
            }
        }
    }
}