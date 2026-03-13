pipeline {
    agent any

    parameters {
        choice(name: 'ACTION', choices: ['start', 'stop'], description: 'Choose action')
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/adityapatel5001/StopandStart.git'
            }
        }

        stage('Run Script') {
            steps {
                sh 'chmod +x start.sh stop.sh'
                script {
                    if (params.ACTION == 'stop') {
                        sh './stop.sh'
                    } else {
                        sh './start.sh'
                    }
                }
            }
        }
    }
}