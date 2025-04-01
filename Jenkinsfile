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
                    sh '''
                    docker run --rm -v "$WORKSPACE:/opt/robotframework/tests" -v "$WORKSPACE/results:/opt/robotframework/reports" \
                    robotframework/robot:latest /opt/robotframework/tests/script.robot
                    '''
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