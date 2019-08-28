pipeline {
    agent { label 'docker' }
    tools {
        maven 'M3'
    }
     environment {
              NEXUS_VERSION = "nexus3"
        // This can be http or https
        NEXUS_PROTOCOL = "http"
        // Where your Nexus is running
        NEXUS_URL = "10.0.0.74:8081"
        // Repository where we will upload the artifact
        NEXUS_REPOSITORY = "microservice"
        // Jenkins credential id to authenticate to Nexus OSS
        NEXUS_CREDENTIAL_ID = "nexus12"
 
   }
    
   
        
    stages {
	stage('Check Style, FindBugs, PMD') {
		steps {
                        sh 'mvn --no-daemon checkstyleMain checkstyleTest findbugsMain findbugsTest pmdMain pmdTest cpdCheck'
			    
	     }
             post {
                     always {
				step([
					$class         : 'FindBugsPublisher',
					pattern        : 'build/reports/findbugs/*.xml',
					canRunOnFailed : true
				])
				step([
					$class         : 'PmdPublisher',
					pattern        : 'build/reports/pmd/*.xml',
					canRunOnFailed : true
				])
				step([
					$class         : 'CheckStylePublisher', 
					pattern        : 'build/reports/checkstyle/*.xml',
					canRunOnFailed : true
				])
			}
		}		
      }
	    
	    
        stage('Build') {
            steps {
                sh 'mvn install'
            }
        }
        
        stage('Test running server') { 
            steps {
                sh 'mvn clean verify' 
            }
            post {
		    always {
                        junit 'target/site/thucydides/*.xml'
		    }
            }
        }
        
        
    }
}
          
