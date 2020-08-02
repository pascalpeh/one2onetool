pipeline {  
     agent any
	 parameters {
        string(name: 'RECIPIENT_EMAIL', defaultValue: 'pascalpeh@hotmail.com', description: 'Email address to receive notifications')
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
        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
        stage('Deploy Docker Container') {
            steps {
                    script {
                        sh "docker pull pascalpeh/one2onetool:${env.BUILD_NUMBER}"
                        try {
                            sh "docker stop one2onetool"
                            sh "docker rm one2onetool"
                            sh "docker image prune -a -f"
                        } catch (err) {
                            echo: 'caught error: $err'
                        }
                        sh "docker run --restart always --name one2onetool-stage -p 3000:3000 -d pascalpeh/one2onetool:${env.BUILD_NUMBER}"
                    }
            }
        }
     }  
	 
     post { 
         always {  
             echo 'Start of Production Release branch'
			 mail bcc: '', body: "<b>Jenkins Job Details</b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> Jenkins build url: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "Jenkins job has started (Project name: ${env.JOB_NAME})", to: "${RECIPIENT_EMAIL}"; 
         }  
         success {  
             echo 'Production Release branch run successfully!'  
			 mail bcc: '', body: "<b>Jenkins Job Details</b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> Jenkins build url: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "Jenkins job ran successfully. Great Work! :) (Project name: ${env.JOB_NAME})", to: "${RECIPIENT_EMAIL}";  
         }  
         failure {
             echo 'Production Release branch has failed. Please check :('  
             mail bcc: '', body: "<b>Jenkins Job Details</b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> Jenkins build url: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "Jenkins job has failed. Please check (Project name: ${env.JOB_NAME})", to: "${RECIPIENT_EMAIL}";  
         }  
     }  
}
