pipeline {

	environment {
		DOCKER = credentials('docker-hub')
	}
	agent any
		stages {
		// Bilding your Test Images
			stage('BUILD') {
				steps {
					sh 'docker build -f Dockerfile \
					-t papermc-prod:trunk .'
				}
			}
			stage('Test') {
				steps {
					echo 'This is the Testing Stage'
				}
			}
// Deploying the minecraft server
			stage('DEPLOY') {
				when {
					branch 'master' // only run these steps on master branch
				}
				steps {
					retry(3) {	
						timeout(time:10, unit: 'MINUTES') {
							sh 'docker tag papermc-prod:trunk groros/papermc-prod:trunk'
                            				sh 'docker push groros/papermc-prod:trunk'
                            				sh 'docker save groros/papermc-prod:trunk | gzip > papermc-prod-golden.tar.gz'
						}
					}
				}
				post {
					failure {
						// sh 'docker stop papermc-prod'
						sh 'docker system prune -f'
						deleteDir()
					}
				}
			}
// Doing containers clean-up to avoid conflicts in future builds
    			stage('CLEAN-UP') {
      				steps {
        				sh 'docker system prune -f'
        				deleteDir()
      				}
    			}
		}
	}

