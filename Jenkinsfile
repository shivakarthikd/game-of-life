pipeline {
    agent any
    tools {
        maven 'M3'
    }
        
    stages {
        stage('Build') {
            steps {
                sh 'mvn install'
            }
        }
        stage('Test') { 
            steps {
                sh 'mvn test' 
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml' 
                }
            }
        }
    }
}
          
