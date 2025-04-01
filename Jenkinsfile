pipeline {
    agent {
        docker { image 'docker:dind' }
    }
    
    environment {
        DOCKER_IMAGE = 'robot-test'
        DOCKER_TAG = 'latest'
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'develop', url: 'https://github.com/Natpapat1929/HomeTest.git'
            }
        }
        
        stage('Run Tests') {
            steps {
                script {
                    docker.image("${env.DOCKER_IMAGE}:${env.DOCKER_TAG}").inside {
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