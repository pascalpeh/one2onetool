pipeline {
    agent any
    parameters {
        string(name: 'DATA_FILE', defaultValue: 'New-Questions.json', description: 'Data File to use')
    }
    triggers {
		githubPush()
	}    
    stages {
        stage('Build') {
            when {
                branch 'master'
            }
            steps {
                echo 'Hello World'
            }
        }
    }
}