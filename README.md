# Updated Readme File

## Overview
This repository demonstrates the use of Jenkins pipelines for performing the following
* Pull repo from Github
* Install npm dependencies and run node unit test
* Build docker image from node.js script in this repo
* Push Docker images to Docker hub
* Pulls docker images from docker hub and runs the containers on Jenkins server (Not recommended if this is running on a real production environment)

## Requirements
* A server running Centos/RedHat with Jenkins, docker, node.js, git packages installed
* Server with public IP address (For Github to send webhooks)
* SMTP server for sending email notifications (Can use free Gmail)
* Github with webhooks configured to Jenkins Server

## Jenkins Server Plugins Requirement
* Pipeline: Multibranch (For running multibranch pipeline)
* Docker Pipeline (For building Docker container in pipeline)
* GitHub plugin (For connecting to github)
* GitHub Integration (For using Github to trigger builds and webhooks)

## How to use/run
1. There are 3 branches in this repo -> Master, Staging and Release. The "Jenkinsfile" & "Dockerfile" are added only in Staging and Release branch which is used to run the Jenkins pipline in each branch
2. Create a "Multi-branch Pipeline" in Jenkins that points to this Github repo. Under "Build Configuration", ensure that it uses the mode "by Jenkinsfile" and Script Path is "Jenkinsfile"
3. The Jenkinsfile in each branch (Staging and Release) will automatically be detected by Jenkins and used to create jobs for respective branch
4. Both containers for staging and release branch will run on the Jenkins Server concurrently with different port numbers. Staging branch container will run on port number 3001 and release branch container will run on port number 3000.
5. To change the Jenkins pipeline jobs or parameters for each branch, modify the Jenkinsfile in each branch accordingly as shown below


### Staging Branch variables ("Jenkinsfile")
Location: staging/Jenkinsfile
Variable Name   | Default Value             | Description
----------------|---------------------------|-------------
DATA_FILE       | Questions-test.json       | Set of questions to use for staging branch
RECIPIENT_EMAIL | recipient@email.com       | Email address to receive Jenkin jobs notifications
GITHUB_REPO_URL | https://github.com/pascalpeh/one2onetool |URL of Github repo
DOCKER_IMAGE    | pascalpeh/one2onetool-stage| Name of docker image to create
CONTAINER_NAME  | one2onetool-stage         | Docker container name to run


### Release Branch variables ("Jenkinsfile")
Location: release/Jenkinsfile
Variable Name   | Default Value             | Description
----------------|---------------------------|-------------
RECIPIENT_EMAIL | recipient@email.com       | Email address to receive Jenkin jobs notifications
GITHUB_REPO_URL | https://github.com/pascalpeh/one2onetool |URL of Github repo
DOCKER_IMAGE    | pascalpeh/one2onetool     | Name of docker image to create
CONTAINER_NAME  | one2onetool               | Docker container name to run
