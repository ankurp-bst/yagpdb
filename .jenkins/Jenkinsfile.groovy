#!groovy
pipeline {

    agent {
    label 'botlabs-bastion-engg'
    }
    stages {
    stage('Checkout code') {
    steps {
        checkout scm
    }
    }
    stage('Build Go Binaries') {
    agent {
        docker {
        image 'golang:1.17.5'
        label 'botlabs-bastion-engg'
        }
        }
        steps {
        sh 'sudo .jenkins/execute.sh'
        }
      }
    stage('Upload Artifacts') {
    steps {
        sh 'sudo .jenkins/upload.sh'
    }
    }
  }
    
}
