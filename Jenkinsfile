pipeline {
    agent { label 'master' }
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
        NEXUS_REPOSITORY = "Gameoflife"
        // Jenkins credential id to authenticate to Nexus OSS
        NEXUS_CREDENTIAL_ID = "nexus12"
 
   }
    
   
        
    stages {
	    
       // stage('Build') {
         //   steps {
           //     sh 'mvn install'
            //}
        //}
	
	//stage ('push articrafts to nexus') {
           // steps {
	     //    script {
                    // Read POM xml file using 'readMavenPom' step , this step 'readMavenPom' is included in: https://plugins.jenkins.io/pipeline-utility-steps
             //       pom = readMavenPom file: "gameoflife-web/pom.xml";
                    // Find built artifact under target folder
               //     filesByGlob = findFiles(glob: "**/*.${pom.packaging}");
		//    echo "${pom.artifactId}"
                    // Print some info from the artifact found
                   // echo "${filesByGlob[1].name} ${filesByGlob[1].path} ${filesByGlob[1].directory} ${filesByGlob[1].length} ${filesByGlob[1].lastModified}"
                    // Extract the path from the File found
		    //artifactID="${BUILD_NUMBER}";
               //     artifactPath = filesByGlob[1].path;
                    // Assign to a boolean response verifying If the artifact name exists
              //      artifactExists = fileExists artifactPath;
                   // if(artifactExists) {
                  //      echo "*** File: ${artifactPath}, group: ${BUILD_NUMBER}";
                 //       nexusArtifactUploader(
                    //        nexusVersion: NEXUS_VERSION,
                     //       protocol: NEXUS_PROTOCOL,
                 //           nexusUrl: NEXUS_URL,
                  //          groupId: pom.groupId,
                 //           version: pom.version,
                  //          repository: NEXUS_REPOSITORY,
                      //      credentialsId: NEXUS_CREDENTIAL_ID,
                           // artifacts: [
                      //          // Artifact generated such as .jar, .ear and .war files.
				//    [ artifactId: pom.parent.artifactId,
                          //      classifier: '',
                          //      file: artifactPath,
                          //      type: pom.packaging],
                                // Lets upload the pom.xml file for additional information for Transitive dependencies
                         //       [artifactId: pom.artifactId,
                         //       classifier: '',
                         //       file: "pom.xml",
                           //     type: "pom"]
                         //   ]
                    //    );
                 //   } else {
                 //       error "*** File: ${artifactPath}, could not be found";
                 //   }
             //   }
			  
          //  }
      //  }
	
	
	stage('deploy'){
		agent { label 'master'}
		steps {
			sh ''' curl -O "http://10.0.0.74:8081/repository/Gameoflife/com/wakaleo/gameoflife/gameoflife/1.0/gameoflife-1.0.war" 
			       cp gameoflife.war /tmp/wepapp1/
			       docker run -d  -it --rm -p 8884:8080 -v /tmp/webapp1:/usr/local/tomcat/webapps tomcat:8.0
			   '''

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
          
