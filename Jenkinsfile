#!/usr/bin/env groovy

properties([disableConcurrentBuilds()])

try {
  def version = getCommitHash()
  cleanUploadFolderIfNeeded(version)
  buildArchitecture('32', '61')
  buildArchitecture('64', '61')
  buildArchitecture('32', '70')
  buildArchitecture('64', '70')
  finalizeUpload(version)
} catch(exception) {
	currentBuild.result = 'FAILURE'
	throw exception
} finally {
     notifyBuild()
}

def getCommitHash(){
  node('linux') {
    //To ensure a clean build we delete the directory, checkout from scm and get the commit hash all from scratch
    deleteDir()
    checkout scm
    return sh(returnStdout: true, script: 'git log -1 --format="%h"').trim()
  }
}

def buildArchitecture(architecture, pharoVersion) {
    withEnv(["ARCHITECTURE=${architecture}", "PHARO=${pharoVersion}"]) {
      node('linux') {
        //To ensure a clean build we delete the directory, checkout from scm and get the commit hash all from scratch
        deleteDir()
        checkout scm
        commitHash = sh(returnStdout: true, script: 'git log -1 --format="%h"').trim()
        
		    stage("Build Pharo${pharoVersion}-${architecture}-bits") {
		    	dir('pharo-build-scripts') {
			    	git('https://github.com/pharo-project/pharo-build-scripts.git')
			    }
			    sh "VERSION=$commitHash ./build.sh prepare"
		    }
    	  stage("Test Pharo${pharoVersion}-${architecture}-bits") {
		    	sh "VERSION=$commitHash ./build.sh test"
			    junit testResults: '*.xml'
		    }
		    stage("Packaging-user Pharo${pharoVersion}-${architecture}-bits") {
		    	sh "VERSION=$commitHash ./build.sh user"
			    stash includes: 'build.sh, mac-installer-background.png, pharo-build-scripts/**, mac/**, windows/**, linux/**, signing/*.p12.enc, icons/**, launcher-version.txt, One/**', name: "pharo-launcher-one-${architecture}"
			    archiveArtifacts artifacts: 'PharoLauncher-user-*.zip', fingerprint: true
        }
		    stage("Packaging-Linux Pharo${pharoVersion}-${architecture}-bits") {
			    sh "VERSION=$commitHash ./build.sh linux-package"
					packageFile = 'PharoLauncher-linux-*-' + fileNameArchSuffix(architecture) + '.zip'
			    archiveArtifacts artifacts: packageFile, fingerprint: true
			    upload(packageFile, commitHash)
			  }
		  }
		  node('windows') {
			  if (architecture == '32') {
	        stage("Packaging-Windows Pharo${pharoVersion}-${architecture}-bits") {
            deleteDir()
            unstash "pharo-launcher-one-${architecture}"
            withCredentials([usernamePassword(credentialsId: 'inriasoft-windows-developper', passwordVariable: 'PHARO_CERT_PASSWORD', usernameVariable: 'PHARO_SIGN_IDENTITY')]) {
					    bat "bash -c \"VERSION=$commitHash ./build.sh win-package\""
            }
            archiveArtifacts artifacts: 'pharo-launcher-*.msi', fingerprint: true
				    stash includes: 'pharo-launcher-*.msi', name: "pharo-launcher-win-${architecture}-package"
          }
			  }
      }
		  node('osx') {
			  stage("Packaging-Mac Pharo${pharoVersion}-${architecture}-bits") {    
          deleteDir()
          unstash "pharo-launcher-one-${architecture}"
          withCredentials([usernamePassword(credentialsId: 'inriasoft-osx-developer', passwordVariable: 'PHARO_CERT_PASSWORD', usernameVariable: 'PHARO_SIGN_IDENTITY')]) {
					  sh "VERSION=$commitHash ./build.sh mac-package"
					}
					archiveArtifacts artifacts: 'PharoLauncher*.dmg', fingerprint: true
				  stash includes: 'PharoLauncher*.dmg', name: "pharo-launcher-osx-${architecture}-package"
				}
      }

    //Do not deploy if in PR
    if (isPullRequest()){
      return;
    }
		node('linux') {
			stage("Deploy Pharo${pharoVersion}-${architecture}-bits") {
          if (currentBuild.result == null || currentBuild.result == 'SUCCESS') {
					  if (architecture == '32') {
					    unstash "pharo-launcher-win-${architecture}-package"
						  upload('pharo-launcher-*.msi', commitHash)
					  }
					  unstash "pharo-launcher-osx-${architecture}-package"
					  fileToUpload = 'PharoLauncher*-' + fileNameArchSuffix(architecture) + '.dmg'
					  upload(fileToUpload, commitHash)
				}
			}
		}
  }
}

def notifyBuild() {
  if (isPullRequest()) {
    //Only notify if not in a PR (i.e., CHANGE_ID not empty)
    echo "[DO NO NOTIFY] In PR " + (env.CHANGE_ID?.trim())
    return;
  }
  
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
  
  stage('Prepare upload') {
    node('linux') {
      sshagent (credentials: ['b5248b59-a193-4457-8459-e28e9eb29ed7']) {
		    sh "ssh -o StrictHostKeyChecking=no \
    		pharoorgde@ssh.cluster023.hosting.ovh.net rm -rf files/pharo-launcher/tmp-${launcherVersion}"
      }
    }
  }
}

def finalizeUpload(launcherVersion) {
  if (isPullRequest()) {
    //Only upload files if not in a PR (i.e., CHANGE_ID not empty)
    echo "[DO NO UPLOAD] In PR " + (env.CHANGE_ID?.trim())
    return;
  }
  
  node('linux') {
    stage('Upload finalization') {
      sshagent (credentials: ['b5248b59-a193-4457-8459-e28e9eb29ed7']) {
      sh "ssh -o StrictHostKeyChecking=no \
    		  pharoorgde@ssh.cluster023.hosting.ovh.net rm -rf files/pharo-launcher/${launcherVersion}"
        sh "ssh -o StrictHostKeyChecking=no \
    	    pharoorgde@ssh.cluster023.hosting.ovh.net mv files/pharo-launcher/tmp-${launcherVersion} files/pharo-launcher/${launcherVersion}"
      }
	  }
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

def fileNameArchSuffix(architecture) {
	return (architecture == '32') ? 'x86' : 'x64'
}

def isPullRequest() {
	return env.CHANGE_ID != null
}
