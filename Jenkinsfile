// Jenkins pipeline: build the Docker image with Kaniko (no Docker daemon needed)
// and push it to the in-cluster registry at 192.168.1.245:5001.
//
// Kaniko runs as a container inside an ephemeral Kubernetes pod that the Jenkins
// Kubernetes plugin spins up for this build, then throws away when done.

pipeline {
  agent {
    kubernetes {
      // Define the build pod: one kaniko container that stays alive while we work.
      yaml '''
apiVersion: v1
kind: Pod
spec:
  containers:
    - name: kaniko
      image: gcr.io/kaniko-project/executor:v1.23.2-debug
      command: ["sleep"]
      args: ["infinity"]
      tty: true
'''
    }
  }

  environment {
    REGISTRY = "192.168.1.245:5001"
    IMAGE    = "hello-world"
  }

  stages {
    stage('Build & Push image') {
      steps {
        container('kaniko') {
          sh '''
            /kaniko/executor \
              --context "$(pwd)" \
              --dockerfile Dockerfile \
              --destination ${REGISTRY}/${IMAGE}:${BUILD_NUMBER} \
              --destination ${REGISTRY}/${IMAGE}:latest \
              --insecure \
              --skip-tls-verify
          '''
        }
      }
    }
  }

  post {
    success {
      echo "Pushed ${REGISTRY}/${IMAGE}:${BUILD_NUMBER} and :latest"
    }
  }
}
