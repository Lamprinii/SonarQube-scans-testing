node {
  stage('SCM') {
    checkout scm
  }
  stage('SonarQube Analysis') {
    def scannerHome = tool 'Asfalis_Sonarqube';
    withSonarQubeEnv() {
      sh "${scannerHome}/bin/sonar-scanner"
    }
  }
  stage('SQLMap Scan') {
            steps {
                script {
                    def targetUrl = "http://example.com/vulnerable_endpoint"
                    def sqlmapOptions = "--batch --dbs"

                    sh "sqlmap -u ${targetUrl} ${sqlmapOptions}"
                }
            }
        }
  stage('Build Docker Image') {
            steps {
                script {
                    // Κατασκευή Docker image
                    sh 'docker build -t my-app:latest .'
                }
            }
        }
        stage('Scan Docker Image for Vulnerabilities') {
            steps {
                script {
                    // Έλεγχος ευπαθειών με Trivy
                    sh 'trivy image my-app:latest'
                }
            }
        }
}
