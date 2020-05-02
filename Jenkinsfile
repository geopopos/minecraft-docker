pipeline {
	environment {
		DOCKER = credentials('docker-hub')
	}
	agent any
		stages {
		// Bilding your Test Images
			stage('BUILD') {
				steps {
					sh 'docker build -f express-image/Dockerfile \
					-t papermc-prod:latest .'
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
						sh 'docker tag papermc-prod:latest groros/papermc-prod:latest'
                            			sh 'docker push groros/papermc-prod:latest'
                            			sh 'docker save groros/papermc-prod:latest | gzip > papermc-prod-golden.tar.gz'
					}
				}
			}
			post {
				failure {
					sh 'docker stop papermc-prod'
					sh 'docker system prune -f'
					deleteDir()
				}
			}
// Doing containers clean-up to avoid conflicts in future builds
    			stage('CLEAN-UP') {
      				steps {
        				sh 'docker stop nodeapp-dev test-image'
        				sh 'docker system prune -f'
        				deleteDir()
      				}
    			}
		}
	}
