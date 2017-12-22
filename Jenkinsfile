#!/usr/bin/env groovy

properties([parameters([
	string(name: 'VERSION', defaultValue: 'bleedingEdge', description: 'Which Pharo Launcher version to build?'),
	string(name: 'PHARO', defaultValue: '61', description: 'Which Pharo image version to use?'),
	string(name: 'VM', defaultValue: 'vm', description: 'Which Pharo vm to use?')
])])

try {
    withEnv(["PHARO=${params.PHARO}",
	         "VM=${params.VM}",
	         "VERSION=${params.VERSION}"]) {

		node('linux') {
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
		    	archiveArtifacts artifacts: 'PharoLauncher-developer*.zip, version.txt', fingerprint: true
		    }

		    stage('Packaging-user') {
		    	sh './build.sh user'
		    	stash includes: 'build.sh, mac-installer-background.png, pharo-build-scripts/**, launcher-version.txt, One/**', name: 'pharo-launcher-one'
		    	archiveArtifacts artifacts: 'PharoLauncher-user-*.zip, PharoLauncher-one-click-packaging.zip', fingerprint: true
		    }

		    stage('Packaging-Linux') {
		    	sh './build.sh linux-package'
		    	archiveArtifacts artifacts: 'Pharo-linux-*.zip', fingerprint: true
		    	upload('Pharo-linux-*.zip', params.VERSION)
		    }
		}
	}
	node('windows') {
		stage('Packaging-Windows') {
			cleanWs()
			unstash 'pharo-launcher-one'
			bat 'bash -c "./build.sh win-package"'
			archiveArtifacts artifacts: 'pharo_installer*.exe', fingerprint: true
		}
   	}
	node('osx') {
		stage('Packaging-Mac') {
			cleanWs()
			unstash 'pharo-launcher-one'
			sh './build.sh mac-package'
			archiveArtifacts artifacts: 'Pharo*.dmg', fingerprint: true
		}
	}
	node('linux') {
		stage('Deploy') {
			if (currentBuild.result == null || currentBuild.result == 'SUCCESS') {
				sh 'ls'
				unarchive // ??
			    sh 'ls && echo publish'
		    }
		}		
	}
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
            replyTo: '$DEFAULT_REPLYTO',
            to: 'christophe.demarey@inria.fr'
    }
}

def upload(file, launcherVersion) {
	sshagent (credentials: ['b5248b59-a193-4457-8459-e28e9eb29ed7']) {
		sh "ssh -o StrictHostKeyChecking=no -v \
    		pharoorgde@ssh.cluster023.hosting.ovh.net mkdir -p files/pharo-launcher/${launcherVersion}"
		sh "scp -o StrictHostKeyChecking=no -v \
				${file} \
    		pharoorgde@ssh.cluster023.hosting.ovh.net:files/pharo-launcher/${launcherVersion}"
    }
}
