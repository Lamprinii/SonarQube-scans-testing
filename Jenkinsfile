node {
  stage('SCM') {
    checkout scm
  }
  stage ('Check-Git-Secrets') {
	  steps {
	    sh 'docker pull gesellix/trufflehog'
	    sh 'docker run -t gesellix/trufflehog --json https://github.com/devopssecure/webapp.git > trufflehog'
	  }
	}
  stage('SonarQube Analysis') {
    def scannerHome = tool 'Asfalis_Sonarqube';
    withSonarQubeEnv() {
      sh "${scannerHome}/bin/sonar-scanner"
    }
  }
}
