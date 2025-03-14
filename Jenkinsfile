pipeline {
  agent any
  stages {
    stage('') {
      steps {
        git(url: 'https://github.com/memor24/kuber-helm-cicd', branch: 'main', changelog: true, poll: true, credentialsId: '1')
      }
    }

  }
  environment {
    env = 'prod'
  }
}