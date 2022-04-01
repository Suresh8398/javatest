pipeline {

    agent any

    tools {
        // Note: this should match with the tool name configured in your jenkins instance (JENKINS_URL/configureTools/)
        maven "Maven 3.8.5"
    }

    
    stages {
        stage("clone code") {
            steps {
                script {
                    // Let's clone the source
                    git 'https://github.com/Suresh8398/javatest.git';
                }
            }
        }

        stage("mvn build") {
            steps {
                script {
                    // If you are using Windows then you should use "bat" step
                    // Since unit testing is out of the scope we skip them
                    sh script: 'mvn clean package'
                    archiveArtifacts artifacts: 'target/*.war', onlyIfSuccessful: true
                }
            }
        }
        
        stage('SonarQube analysis') {
    //  def scannerHome = tool 'SonarScanner 4.0';
             steps {
                 withSonarQubeEnv('sonarqube-7.6') { 
    //           sh "${scannerHome}/bin/sonar-scanner"
                 sh "mvn sonar:sonar"

                }

            }

        }
        
        stage("publish to nexus") {
            steps {
              script{
                def mavenPom = readMavenPom file: 'pom.xml'
                def nexusRepoName = mavenPom.version.endsWith("SNAPSHOT") ? "simpleapp-snapshot" : "simpleapp-release"
                nexusArtifactUploader artifacts: [
                    [
                        artifactId: 'simple-app',
                        classifier: '', 
                        file: 'target/simple-app-3.0.0-SNAPSHOT.war',
                        type: 'war'
                    ]
                ], 
                credentialsId: 'Nexus-cred', 
                groupId: 'in.javahome', 
                nexusUrl: '18.236.148.16:8081', 
                nexusVersion: 'nexus3', 
                protocol: 'http', 
                repository: 'maven-repo', 
                version: '${mavenPom.version}'

                }
                    
            }
        }
		stage("terraform init"){
            steps{
               sh label: '', script: 'terraform init'
               }
            }
        
        stage("terraform apply"){
            steps{
                sh label: '', script: 'terraform  destroy --auto-approve'
                
            }
        }

        stage("Ansible Deployment"){
            steps{
                ansiblePlaybook credentialsId: 'deploy_key', disableHostKeyChecking: true, installation: 'ansible', inventory: 'aws_ec2.yml', playbook: 'install.yml'
            }
        }
    }
}
