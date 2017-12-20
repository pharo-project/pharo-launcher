#!/usr/bin/env groovy

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
		    	stash includes: 'PharoLauncher-one-click-packaging.zip, build.sh, mac-installer-background.png, pharo-build-scripts, launcher-version.txt, One', name: 'pharo-launcher-one'
		    	archiveArtifacts artifacts: 'PharoLauncher-user-*.zip, PharoLauncher-one-click-packaging.zip', fingerprint: true
		    }

		    stage('Packaging-Linux') {
		    	sh './build.sh linux-package'
		    	archiveArtifacts artifacts: 'Pharo-linux-*.zip', fingerprint: true
		    	node('windows') {
		    		cleanWs()
		    		unstash 'pharo-launcher-one'
		    		sh './build.sh win-package'
		    		archiveArtifacts artifacts: 'pharo_installer*.exe', fingerprint: true
		    	}
		    }

		    stage('Deploy') {
				if (currentBuild.result == null || currentBuild.result == 'SUCCESS') { 
		            sh 'echo publish'
		        }
		    }
		}
	}
	/*node('windows') {
	    withEnv(["PHARO=${params.PHARO}",
	             "VM=${params.VM}"]) {
		    stage('Packaging-Windows') {
		    	sh './build.sh win-package'
		    	archiveArtifacts artifacts: 'pharo_installer*.exe', fingerprint: true
		    }
		}
	}
	node('mac') {
	    withEnv(["PHARO=${params.PHARO}",
	             "VM=${params.VM}"]) {
		    stage('Packaging-Mac') {
		    	sh './build.sh mac-package'
		    	archiveArtifacts artifacts: 'Pharo*.dmg', fingerprint: true
		    }

	    }
	}*/
} catch(exception) {
	currentBuild.result = 'FAILURE'
	throw exception
} finally {
     notifyBuild()
}

def notifyBuild() {
	if (currentBuild.result != 'SUCCESS') { // Possible values: SUCCESS, UNSTABLE, FAILURE
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
