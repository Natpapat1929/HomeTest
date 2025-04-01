pipeline {
        agent {
        docker {
            image 'ppodgorsek/robot-framework'
        }
        }

        stages {
            stage('Checkout') {
                steps {
g                   it branch: 'develop', url: 'https://github.com/YOUR_USER/YOUR_REPO.git'
                }
            }

        stage('Run Tests') {
            steps {
                script {
                        sh 'robot --outputdir results/ script.robot'
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
}