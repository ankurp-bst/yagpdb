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
        sh '.jenkins/execute.sh'
        }
      }
    stage('Upload Artifacts') {
    steps {
        sh '.jenkins/upload.sh'
    }
    }
  }
    post {
        always {
            echo 'IM THE MAILER'
            
            emailext body: "${currentBuild.currentResult}: Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n More info at: ${env.BUILD_URL}",
                to: "ashish.jhanwar@bluestacks.com,mohammad.mazid@bluestacks.com,pankajkumar.jaiswal@bluestacks.com" ,
                subject: "Jenkins Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}"      
        }
    }
}
