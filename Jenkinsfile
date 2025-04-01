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
                    sh 'docker exec robot-test robot --outputdir /opt/robotframework/reports /opt/robotframework/tests/script.robot'
                }

                archiveArtifacts artifacts: 'results/log.html,results/output.xml,results/report.html', allowEmptyArchive: true

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