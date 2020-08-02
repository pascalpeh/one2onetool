pipeline {  
     agent any
	 parameters {
        string(name: 'DATA_FILE', defaultValue: 'Questions-Test.json', description: 'Data file for staging environment')
	 }
	 triggers {
		githubPush()
	 }
     stages {  
         stage('Start Staging') {
             steps {  
                 sh 'echo "Staging branch Started"'
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
			 mail bcc: '', body: "<b>Jenkins Job Details</b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> Jenkins build url: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "Jenkins job ran successfully. Great Job! (Project name: ${env.JOB_NAME})", to: "pascalpeh@hotmail.com";  
         }  
         failure {  
             mail bcc: '', body: "<b>Jenkins Job Details</b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> Jenkins build url: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "Jenkins job has failed. Please check (Project name: ${env.JOB_NAME})", to: "pascalpeh@hotmail.com";  
         }  
     }  
}
