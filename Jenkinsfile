pipeline {
    agent { label 'fargatec2' }
     environment {
              NEXUS_VERSION = "nexus3"
        // This can be http or https
        NEXUS_PROTOCOL = "http"
        // Where your Nexus is running
        NEXUS_URL = "10.0.0.74:8081"
        // Repository where we will upload the artifact
        NEXUS_REPOSITORY = "Gameoflife"
        // Jenkins credential id to authenticate to Nexus OSS
        NEXUS_CREDENTIAL_ID = "nexus12"
 
   }
    
   
        
    stages {
	    
        stage('build && SonarQube analysis') {
            steps {
                withSonarQubeEnv('My SonarQube Server') {
                    // Optionally use a Maven environment you've configured already
                    withMaven(maven:'M3') {
                        sh 'mvn clean package sonar:sonar'
                    }
                }
            }
	}
        
	
	stage ('push articrafts to nexus') {
            steps {
	         script {
                    // Read POM xml file using 'readMavenPom' step , this step 'readMavenPom' is included in: https://plugins.jenkins.io/pipeline-utility-steps
                    pom = readMavenPom file: "gameoflife-web/pom.xml";
                    // Find built artifact under target folder
                   filesByGlob = findFiles(glob: "**/*.${pom.packaging}");
		//    echo "${pom.artifactId}"
                    // Print some info from the artifact found
                   echo "${filesByGlob[0].name} ${filesByGlob[0].path} ${filesByGlob[0].directory} ${filesByGlob[0].length} ${filesByGlob[0].lastModified}"
                    // Extract the path from the File found
		    //artifactID="${BUILD_NUMBER}";
                  artifactPath = filesByGlob[0].path;
                    // Assign to a boolean response verifying If the artifact name exists
                    artifactExists = fileExists artifactPath;
                    if(artifactExists) {
                        echo "*** File: ${artifactPath}, group: ${BUILD_NUMBER}";
                        nexusArtifactUploader(
                            nexusVersion: NEXUS_VERSION,
                            protocol: NEXUS_PROTOCOL,
                            nexusUrl: NEXUS_URL,
                            groupId: pom.groupId,
                            version: pom.version,
                            repository: NEXUS_REPOSITORY,
                            credentialsId: NEXUS_CREDENTIAL_ID,
                            artifacts: [
                                // Artifact generated such as .jar, .ear and .war files.
				    [ artifactId: pom.parent.artifactId,
                                classifier: '',
                                file: artifactPath,
                                type: pom.packaging],
                                // Lets upload the pom.xml file for additional information for Transitive dependencies
                                [artifactId: pom.artifactId,
                                classifier: '',
                                file: "pom.xml",
                                type: "pom"]
                            ]
                        );
                    } else {
                        error "*** File: ${artifactPath}, could not be found";
                    }
                }
			  
            }
        }
	
	
	stage('deploy'){
		agent { label 'master' }
		steps {         
			  
			   sh ''' curl -u $NEXUS_CREDENTIAL_ID -O "http://10.0.0.74:8081/repository/Gameoflife/com/wakaleo/gameoflife/gameoflife/1.0/gameoflife-1.0.war"
			          docker build -t gameoflife:latest .  
					  '''
                           aquaMicroscanner imageName: 'gameoflife:latest' , onDisallowed:'false' , notCompliesCmd:'exit 1' , outputFormat:''		
      			  
		           sh ' docker run -d  -it --rm -p 8383:8080  gameoflife:latest'
		}

     
          }
        
        stage('Test running server') { 
            steps {
                sh 'mvn clean verify' 
            }
        }
        
        
    }
}
