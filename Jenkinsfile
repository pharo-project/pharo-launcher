properties([parameters([
	string(name: 'VERSION', defaultValue: 'bleedingEdge', description: 'Which Pharo Launcher version to build?'),
	string(name: 'PHARO', defaultValue: '61', description: 'Which Pharo image version to use?'),
	string(name: 'VM', defaultValue: 'vm', description: 'Which Pharo vm to use?')
])])


try {
	node('linux') {

	    withEnv(["PHARO=${params.PHARO}",
	             "VM=${params.VM}"]) {

		    stage('Build') {
		    	cleanWs()
		    	checkout scm
		    	dir('pharo-build-scripts') {
		    		git('https://github.com/pharo-project/pharo-build-scripts.git')
		    	}
		        sh "./build.sh prepare ${params.VERSION}"
		    }

		    stage('Test') {
		    	sh './build.sh test'
		        junit '*.xml'
		    }

		    stage('Packaging-developer') {
		    	sh './build.sh developer'
		    	archiveArtifacts artifacts: 'PharoLauncher-developer.zip, version.txt', fingerprint: true
		    }

		    stage('Packaging-user') {
		    	sh './build.sh user'
		    	archiveArtifacts artifacts: 'PharoLauncher-user-*.zip, Pharo-mac.zip, Pharo-win.zip, Pharo-linux.zip, version.txt', fingerprint: true
		    }

		    stage('Deploy') {
				if (currentBuild.result == null || currentBuild.result == 'SUCCESS') { 
		            sh 'zecho publish'
		        }
		    }
		}
	}
} catch(exception) {
	notifyBuild("FAILURE")
	throw exception
} finally {
     notifyBuild(currentBuild.result)
}

def notifyBuild(status) {
	if (currentBuild.currentResult != 'SUCCESS') { // Possible values: SUCCESS, UNSTABLE, FAILURE
        // Send an email only if the build status has changed from green to unstable or red
        emailext subject: '$DEFAULT_SUBJECT',
            body: '$DEFAULT_CONTENT',
            recipientProviders: [
                [$class: 'CulpritsRecipientProvider'],
                [$class: 'DevelopersRecipientProvider'],
                [$class: 'RequesterRecipientProvider']
            ], 
            replyTo: '$DEFAULT_REPLYTO',
            to: 'christophe.demarey@inria.fr'
    }
}