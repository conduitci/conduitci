node {
  stage('Checkout') {
    checkout scm
  }
  
  def newApp
  def gitCommit
  stage('Build') {
    sh 'git rev-parse HEAD > GIT_COMMIT'
    sh 'git rev-parse --abbrev-ref HEAD > GIT_BRANCH'
    gitCommit = readFile('GIT_COMMIT').trim()
    gitBranch = readFile('GIT_BRANCH').trim()
    env.GIT_COMMIT = gitCommit
    env.GIT_BRANCH = gitBranch
    
    def imageName = "conduitci/core:${gitCommit}"
    ansiColor('xterm') {
      newApp = docker.build(imageName, "--build-arg GIT_COMMIT=${gitCommit} --build-arg GIT_BRANCH=${gitBranch} .")
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
