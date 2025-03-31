pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = 'jenkins/jenkins'
        DOCKER_TAG = 'latest'
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Natpapat1929/HomeTest.git'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${env.DOCKER_IMAGE}:${env.DOCKER_TAG}", "--file Dockerfile .")
                }
            }
        }
        
        stage('Run Tests') {
            steps {
                script {
                    // Run tests in Docker container and capture artifacts
                    docker.image("${env.DOCKER_IMAGE}:${env.DOCKER_TAG}").inside {
                        sh 'python -m pytest --html=report.html --self-contained-html'
                        sh 'robot --outputdir results/ script.robot'
                    }
                    
                    // Archive test results
                    archiveArtifacts artifacts: 'report.html', allowEmptyArchive: true
                    archiveArtifacts artifacts: 'results/log.html,results/output.xml,results/report.html', allowEmptyArchive: true
                    
                    // Publish HTML report
                    publishHTML(target: [
                        allowMissing: false,
                        alwaysLinkToLastBuild: false,
                        keepAll: true,
                        reportDir: '.',
                        reportFiles: 'report.html',
                        reportName: 'HTML Report'
                    ])
                }
            }
        }
    }
}