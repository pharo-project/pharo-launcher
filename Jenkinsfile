#!/usr/bin/env groovy

properties([disableConcurrentBuilds()])

try {
    def builders = [:]
    builders['pharo7-32'] = { buildArchitecture('32', '70') }
    builders['pharo7-64'] = { buildArchitecture('64', '70') }
    builders['pharo6-32'] = { buildArchitecture('32', '61') }
    builders['pharo6-64'] = { buildArchitecture('64', '61') }
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

def buildArchitecture(architecture, pharoVersion) {
    withEnv(["ARCHITECTURE=${architecture}", "PHARO=${pharoVersion}", "VERSION=${sha1}"]) {
		node('linux') {
        deleteDir()
		    stage("Build Pharo${pharoVersion}-${architecture}-bits") {
		    	dir("Pharo${pharoVersion}-${architecture}") {
			    	checkout scm
			    	dir('pharo-build-scripts') {
			    		git('https://github.com/pharo-project/pharo-build-scripts.git')
			    	}
			      sh "./build.sh prepare"
		    	}
		    }

		    stage("Test Pharo${pharoVersion}-${architecture}-bits") {
		    	dir("Pharo${pharoVersion}-${architecture}") {
			    	sh "./build.sh test"
			        junit '*.xml'
			    }
		    }
		    stage("Packaging-developer Pharo${pharoVersion}-${architecture}-bits") {
		    	dir("Pharo${pharoVersion}-${architecture}") {
			    	sh './build.sh developer'
			    	archiveArtifacts artifacts: 'PharoLauncher-developer*.zip, version.txt', fingerprint: true
			    	if ( isBleedingEdgeVersion() )
			    		upload('PharoLauncher-developer*.zip', params.VERSION)
			    }
		    }

		    stage("Packaging-user Pharo${pharoVersion}-${architecture}-bits") {
		    	dir("Pharo${pharoVersion}-${architecture}") {
			    	sh './build.sh user'
			    	stash includes: 'build.sh, mac-installer-background.png, pharo-build-scripts/**, mac/**, windows/**, linux/**, signing/*.p12.enc, icons/**, launcher-version.txt, One/**', name: "pharo-launcher-one-${architecture}"
			    	archiveArtifacts artifacts: 'PharoLauncher-user-*.zip', fingerprint: true
			    	if ( isBleedingEdgeVersion() )
			    		upload('PharoLauncher-user-*.zip', params.VERSION)
			    }
		    }

		    stage("Packaging-Linux Pharo${pharoVersion}-${architecture}-bits") {
		    	dir("Pharo${pharoVersion}-${architecture}") {
			    	sh './build.sh linux-package'
					packageFile = 'PharoLauncher-linux-*-' + fileNameArchSuffix(architecture) + '.zip'
			    	archiveArtifacts artifacts: packageFile, fingerprint: true
			    	upload(packageFile, params.VERSION)
			    }
		    }
		}
		node('windows') {
			if (architecture == '32') {
				stage("Packaging-Windows Pharo${pharoVersion}-${architecture}-bits") {
          deleteDir()
					unstash "pharo-launcher-one-${architecture}"
					withCredentials([usernamePassword(credentialsId: 'inriasoft-windows-developper', passwordVariable: 'PHARO_CERT_PASSWORD', usernameVariable: 'PHARO_SIGN_IDENTITY')]) {
						bat 'bash -c "./build.sh win-package"'
					}
					archiveArtifacts artifacts: 'pharo-launcher-*.msi', fingerprint: true
				    stash includes: 'pharo-launcher-*.msi', name: "pharo-launcher-win-${architecture}-package"
				}
			}
	   	}
		node('osx') {
			stage("Packaging-Mac Pharo${pharoVersion}-${architecture}-bits") {
          deleteDir()
		    	dir("Pharo${pharoVersion}-${architecture}") {
					unstash "pharo-launcher-one-${architecture}"
					withCredentials([usernamePassword(credentialsId: 'inriasoft-osx-developer', passwordVariable: 'PHARO_CERT_PASSWORD', usernameVariable: 'PHARO_SIGN_IDENTITY')]) {
						sh './build.sh mac-package'
					}
					archiveArtifacts artifacts: 'PharoLauncher*.dmg', fingerprint: true
				    stash includes: 'PharoLauncher*.dmg', name: "pharo-launcher-osx-${architecture}-package"
				}
			}
		}
		node('linux') {
			stage("Deploy Pharo${pharoVersion}-${architecture}-bits") {
		    dir("Pharo${pharoVersion}-${architecture}") {
          deleteDir()
          if (currentBuild.result == null || currentBuild.result == 'SUCCESS') {
					  if (architecture == '32') {
					    unstash "pharo-launcher-win-${architecture}-package"
						  upload('pharo-launcher-*.msi', params.VERSION)
					  }
					  unstash "pharo-launcher-osx-${architecture}-package"
					  fileToUpload = 'PharoLauncher*-' + fileNameArchSuffix(architecture) + '.dmg'
					  upload(fileToUpload, params.VERSION)
          }
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
  if (isPullRequest()) {
    //Only upload files if not in a PR (i.e., CHANGE_ID not empty)
    echo "[DO NO UPLOAD] In PR " + (env.CHANGE_ID?.trim())
    return;
  }
  
	sshagent (credentials: ['b5248b59-a193-4457-8459-e28e9eb29ed7']) {
		sh "ssh -o StrictHostKeyChecking=no \
    		pharoorgde@ssh.cluster023.hosting.ovh.net rm -rf files/pharo-launcher/tmp-${launcherVersion}"
    }
}

def finalizeUpload(launcherVersion) {
  if (isPullRequest()) {
    //Only upload files if not in a PR (i.e., CHANGE_ID not empty)
    echo "[DO NO UPLOAD] In PR " + (env.CHANGE_ID?.trim())
    return;
  }
  
	sshagent (credentials: ['b5248b59-a193-4457-8459-e28e9eb29ed7']) {
		sh "ssh -o StrictHostKeyChecking=no \
    		pharoorgde@ssh.cluster023.hosting.ovh.net rm -rf files/pharo-launcher/${launcherVersion}"
		sh "ssh -o StrictHostKeyChecking=no \
    		pharoorgde@ssh.cluster023.hosting.ovh.net mv files/pharo-launcher/tmp-${launcherVersion} files/pharo-launcher/${launcherVersion}"
    }
}

def upload(file, launcherVersion) {
  if (isPullRequest()) {
    //Only upload files if not in a PR (i.e., CHANGE_ID not empty)
    echo "[DO NO UPLOAD] In PR " + (env.CHANGE_ID?.trim())
    return;
  }
    
	def expandedFileName = sh(returnStdout: true, script: "echo ${file}").trim()
	sshagent (credentials: ['b5248b59-a193-4457-8459-e28e9eb29ed7']) {
		sh "ssh -o StrictHostKeyChecking=no \
    		pharoorgde@ssh.cluster023.hosting.ovh.net mkdir -p files/pharo-launcher/tmp-${launcherVersion}"
		sh "scp -o StrictHostKeyChecking=no \
			${expandedFileName} \
			pharoorgde@ssh.cluster023.hosting.ovh.net:files/pharo-launcher/tmp-${launcherVersion}"
    }
}

def isBleedingEdgeVersion() {
	return isPullRequest()
}

def fileNameArchSuffix(architecture) {
	return (architecture == '32') ? 'x86' : 'x64'
}

def isPullRequest() {
	return env.CHANGE_ID != null
}