pipeline {
    agent any
    parameters {
        choice(name: 'Node_count', choices: ['1', '2', '3','4','5'], description: 'Node_Count')
    }
    stages {
        stage('Set Job Name') {
            steps {
                script {
                    if(currentBuild.rawBuild.project.displayName != 'selenium-grid') {
                        currentBuild.rawBuild.project.description = 'selenium-grid-test'
                        currentBuild.rawBuild.project.setDisplayName('selenium-grid')
                    }
                    else {
                        echo 'Name change not required'
                    }
                }
            }
        }
        stage('Set Build name') {
            steps {
                script {
                    currentBuild.displayName = "My_Build_${BUILD_NUMBER}"
                    currentBuild.description = "The best description."
                }
            }
        }
        stage('Paramater') {
            steps {
                echo "Choice: ${params.Node_count}"
            }
        }
        stage('Deploy and test') {
            steps {
                sh label: '''Deploying''' , script: """./runner.sh ${params.Node_count} | tee /tmp/output.txt"""
                script {
                    output = sh (script:'cat /tmp/output.txt | grep "Ran" | cut -d " " -f4-', returnStdout:true).trim()
                }
            }
            // post {
            //     always{
            //         sh 'docker-compose down --remove-orphans'
            //     }
            // }
        }
        stage('Webhook') {
            steps {
                sh label: '''send test results''' , script: """curl --data "result=${output}" https://webhook.site/ba067bf7-531a-4a6b-9afb-fde074d2e23d"""
                
                    }
                }
            }
        post {
            always{
                cleanWs ()
            }
        }
    }