#!/usr/bin/env groovy

properties([parameters([
	string(name: 'VERSION', defaultValue: 'bleedingEdge', description: 'Which Pharo Launcher version to build?'),
	string(name: 'PHARO', defaultValue: '61', description: 'Which Pharo image version to use?'),
	string(name: 'VM', defaultValue: 'vm', description: 'Which Pharo vm to use?')
])])

try {
    def builders = [:]
    builders['32'] = { buildArchitecture('32') }
    // builders['64'] = { buildArchitecture('64') }
    node('linux') {
    	stage('Prepare upload') {
    		cleanUploadFolderIfNeeded(params.VERSION)
    	}
    }
    parallel builders
    node('linux') {
    	stage('Upload finalization') {
    		finalizeUpload(params.VERSION)
    	}
    }
} catch(exception) {
	currentBuild.result = 'FAILURE'
	throw exception
} finally {
     notifyBuild()
}

def buildArchitecture(architecture) {
    withEnv(["ARCHITECTURE=${architecture}"]) {
		node('linux') {
		    stage("Build ${architecture}-bits") {
		    	cleanWs()
		    	checkout scm
		    	dir('pharo-build-scripts') {
		    		git('https://github.com/pharo-project/pharo-build-scripts.git')
		    	}
		        sh "./build.sh prepare ${params.VERSION}"
		    }

		    stage("Test ${architecture}-bits") {
		    	sh './build.sh test'
		        junit '*.xml'
		    }

		    stage("Packaging-developer ${architecture}-bits") {
		    	sh './build.sh developer'
		    	archiveArtifacts artifacts: 'PharoLauncher-developer*.zip, version.txt', fingerprint: true
		    	if ( isBleedingEdgeVersion() )
		    		upload('PharoLauncher-developer*.zip', params.VERSION)
		    }

		    stage("Packaging-user ${architecture}-bits") {
		    	sh './build.sh user'
		    	stash includes: 'build.sh, mac-installer-background.png, pharo-build-scripts/**, mac/**, windows/**, icons/**, launcher-version.txt, One/**', name: "pharo-launcher-one-${architecture}"
		    	archiveArtifacts artifacts: 'PharoLauncher-user-*.zip', fingerprint: true
		    	if ( isBleedingEdgeVersion() )
		    		upload('PharoLauncher-user-*.zip', params.VERSION)
		    }

		    stage("Packaging-Linux ${architecture}-bits") {
		    	sh './build.sh linux-package'
		    	archiveArtifacts artifacts: 'PharoLauncher-linux-*.zip', fingerprint: true
		    	upload('PharoLauncher-linux-*.zip', params.VERSION)
		    }
		}
		node('windows') {
			if (architecture == '32') {
				stage("Packaging-Windows ${architecture}-bits") {
					cleanWs()
					unstash "pharo-launcher-one-${architecture}"
					bat 'bash -c "./build.sh win-package"'
					archiveArtifacts artifacts: 'pharo-launcher-installer*.exe', fingerprint: true
				    stash includes: 'pharo-launcher-*.msi', name: "pharo-launcher-win-${architecture}-packages"
				}
			}
	   	}
		node('osx') {
			stage("Packaging-Mac ${architecture}-bits") {
				cleanWs()
				unstash "pharo-launcher-one-${architecture}"
				withCredentials([usernamePassword(credentialsId: 'inriasoft-osx-developer', passwordVariable: 'PHARO_CERT_PASSWORD', usernameVariable: 'PHARO_SIGN_IDENTITY')]) {
					sh './build.sh mac-package'
				}
				archiveArtifacts artifacts: 'PharoLauncher*.dmg', fingerprint: true
			    stash includes: 'PharoLauncher*.dmg', name: "pharo-launcher-osx-${architecture}-packages"
			}
		}
		node('linux') {
			stage("Deploy ${architecture}-bits") {
				if (currentBuild.result == null || currentBuild.result == 'SUCCESS') {
				    if (architecture == '32') {
				    	unstash "pharo-launcher-win-${architecture}-packages"
					    upload('pharo-launcher-*.msi', params.VERSION)
				    }
				    unstash "pharo-launcher-osx-${architecture}-packages"
				    upload('PharoLauncher*.dmg', params.VERSION)
			    }
			}		
		}
    }
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

def cleanUploadFolderIfNeeded(launcherVersion) {
	sshagent (credentials: ['b5248b59-a193-4457-8459-e28e9eb29ed7']) {
		sh "ssh -o StrictHostKeyChecking=no \
    		pharoorgde@ssh.cluster023.hosting.ovh.net rm -rf files/pharo-launcher/tmp-${launcherVersion}"
    }
}

def finalizeUpload(launcherVersion) {
	sshagent (credentials: ['b5248b59-a193-4457-8459-e28e9eb29ed7']) {
		sh "ssh -o StrictHostKeyChecking=no \
    		pharoorgde@ssh.cluster023.hosting.ovh.net rm -rf files/pharo-launcher/${launcherVersion}"
		sh "ssh -o StrictHostKeyChecking=no \
    		pharoorgde@ssh.cluster023.hosting.ovh.net mv files/pharo-launcher/tmp-${launcherVersion} files/pharo-launcher/${launcherVersion}"
    }
}

def upload(file, launcherVersion) {
	sshagent (credentials: ['b5248b59-a193-4457-8459-e28e9eb29ed7']) {
		sh "ssh -o StrictHostKeyChecking=no \
    		pharoorgde@ssh.cluster023.hosting.ovh.net mkdir -p files/pharo-launcher/tmp-${launcherVersion}"
		sh "scp -o StrictHostKeyChecking=no \
				${file} \
    		pharoorgde@ssh.cluster023.hosting.ovh.net:files/pharo-launcher/tmp-${launcherVersion}"
    }
}

def isBleedingEdgeVersion() {
	return params.VERSION == 'bleedingEdge'
}
