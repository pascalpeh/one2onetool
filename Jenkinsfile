pipeline {
    agent any
    parameters {
        string(name: 'DATA_FILE', defaultValue: 'New-Questions.json', description: 'Data File to use')
    }
    triggers {
		githubPush()
	}    
    stages {
        stage('Echo Hello World') {
            when {
                branch 'master'
            }
            steps {
                echo 'Hello World'
            }
        }

        stage('Build Docker Image') {
            when {
                branch 'master'
            }
            steps {
                script {
                    app = docker.build("pascalpeh/one2onetool")
                    app.inside {
                        sh 'echo $(curl localhost:3000)'
                    }
                }
            }
        }

        stage('Push Docker Image to Docker.io') {
            when {
                branch 'master'
            }
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }


    }
}