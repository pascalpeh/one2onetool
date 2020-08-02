pipeline {  
     agent any
	 parameters {
        string(name: 'DATA_FILE', defaultValue: 'Questions-Test.json', description: 'Data file for staging environment')
	 }
	 triggers {
		githubPush()
	 }
     stages {  
        stage('Clone from Github') {
             steps {
                 git branch: 'staging', url: 'https://github.com/pascalpeh/one2onetool'
             }  
        }
        stage('Install npm dependencies') {
             steps {
                 sh 'npm install'
             }  
        }
        stage('Start nodejs unit tests') {
             steps {
                 sh 'npm run test'
             }  
        }
        stage('Build Docker Image') {
            steps {
                script {
                    app = docker.build("pascalpeh/one2onetool")
                    app.inside {
                        sh 'echo $(curl localhost:3000)'
                    }
                }
            }
        }
     }  
	 
     post {  
         always {  
             echo 'Start of Staging branch'
			 mail bcc: '', body: "<b>Jenkins Job Details</b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> Jenkins build url: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "Jenkins job has started (Project name: ${env.JOB_NAME})", to: "pascalpeh@hotmail.com"; 
         }  
         success {  
             echo 'Staging branch run successfully!'  
			 mail bcc: '', body: "<b>Jenkins Job Details</b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> Jenkins build url: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "Jenkins job ran successfully. Great Job! :) (Project name: ${env.JOB_NAME})", to: "pascalpeh@hotmail.com";  
         }  
         failure {
             echo 'Staging branch has failed. Please check :('  
             mail bcc: '', body: "<b>Jenkins Job Details</b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> Jenkins build url: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "Jenkins job has failed. Please check (Project name: ${env.JOB_NAME})", to: "pascalpeh@hotmail.com";  
         }  
     }  
}
