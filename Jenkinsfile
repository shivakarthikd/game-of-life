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
        }
        stage('Run'){
            steps {
                sh 'mvn jetty:run'
            }
        }
    }
}
          
