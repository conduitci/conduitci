node {
  stage('Checkout') {
    checkout scm
  }
  
  def newApp
  def gitCommit
  stage('Build') {
    sh 'git rev-parse HEAD > GIT_COMMIT'
    gitCommit = readFile('GIT_COMMIT').trim()
    def imageName = "conduitci/core:${gitCommit}"
    ansiColor('xterm') {
      newApp = docker.build(imageName)
    }
  }
  
  stage('Push') {
    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-login-conduit') {
      newApp.push()
    }
  }
  
  stage('Deploy') {
    sh "sed \$'s/\$GIT_COMMIT/${gitCommit}/' < kubernetes.yml | kubectl apply -f - --namespace=default"
  }
}
