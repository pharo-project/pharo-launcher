#!/usr/bin/env groovy

properties([disableConcurrentBuilds()])

try {
  isRelease = false
  version = getVersion()
  println "Building Pharo Launcher $version"
  cleanUploadFolderIfNeeded(uploadDirectoryName())
  timeout(time: 60, unit: 'MINUTES') { 
    // buildArchitecture('32', '80')
    buildArchitecture('64', '100')
    buildArchitecture('arm64', '100')
  }
  finalizeUpload(uploadDirectoryName())
} catch(exception) {
  currentBuild.result = 'FAILURE'
  throw exception
} finally {
     notifyBuild()
}

def buildArchitecture(architecture, pharoVersion) {
    withEnv(["ARCHITECTURE=${architecture}", "PHARO=${pharoVersion}"]) {
      node('linux') {
        //To ensure a clean build we delete the directory, checkout from scm and get the commit hash all from scratch
        deleteDir()
        checkout scm
        
        stage("Build Pharo${pharoVersion}-${architecture}-bits") {
          dir('pharo-build-scripts') {
            git('https://github.com/pharo-project/pharo-build-scripts.git')
          }
          sh "VERSION=$version ./build.sh prepare"
        }
        stage("Test Pharo${pharoVersion}-${architecture}-bits") {
          sh "VERSION=$version ./build.sh test"
          junit '*.xml'
        }
        stage("Packaging-user Pharo${pharoVersion}-${architecture}-bits") {
          sh "VERSION=$version ./build.sh user"
          stash includes: 'build.sh, mac-installer-background.png, pharo-build-scripts/**, mac/**, windows/**, linux/**, signing/*.p12.enc, icons/**, launcher-version.txt, One/**', name: "pharo-launcher-one-${architecture}"
          archiveArtifacts artifacts: 'PharoLauncher-user-*.zip', fingerprint: true
        }
        stage("Packaging-Linux Pharo${pharoVersion}-${architecture}-bits") {
          sh "VERSION=$version ./build.sh linux-package"
          packageFile = 'PharoLauncher-linux-*-' + fileNameArchSuffix(architecture) + '.zip'
          archiveArtifacts artifacts: packageFile, fingerprint: true
          upload(packageFile, uploadDirectoryName())
        }
      }
      node('windows') {
        stage("Packaging-Windows Pharo${pharoVersion}-${architecture}-bits") {
          when {
            not { environment(name: "ARCHITECTURE", value: "arm64") }
          }
          deleteDir()
          unstash "pharo-launcher-one-${architecture}"
          // Disable signing for now because the signing process now requires manual action
          /* if ( isPullRequest() ) { // Do not give access to certificates and do not sign */
            bat "bash -c \"VERSION=$version IS_RELEASE=$isRelease ./build.sh win-package\""
          /* } else { 
            withCredentials([usernamePassword(credentialsId: 'inriasoft-windows-developper', passwordVariable: 'PHARO_CERT_PASSWORD', usernameVariable: 'PHARO_SIGN_IDENTITY')]) {
              bat "bash -c \"VERSION=$version IS_RELEASE=$isRelease SHOULD_SIGN=true ./build.sh win-package\""
            }              
          } */
          archiveArtifacts artifacts: 'pharo-launcher-*.msi, Pharo-win.zip', fingerprint: true
          stash includes: 'pharo-launcher-*.msi', name: "pharo-launcher-win-${architecture}-package"
        }
      }
      node('osx') {
        stage("Packaging-Mac Pharo${pharoVersion}-${architecture}-bits") {    
          deleteDir()
          unstash "pharo-launcher-one-${architecture}"
          if ( isPullRequest() ) { // Do not give access to certificates and do not sign
            sh "VERSION=$version ./build.sh mac-package"
          } else {
            withCredentials([usernamePassword(credentialsId: 'inriasoft-osx-developer', passwordVariable: 'PHARO_CERT_PASSWORD', usernameVariable: 'PHARO_SIGN_IDENTITY')]) {
              sh "VERSION=$version SHOULD_SIGN=true ./build.sh mac-package"
            }
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
            unstash "pharo-launcher-win-${architecture}-package"
            upload('pharo-launcher-*.msi', uploadDirectoryName())
            unstash "pharo-launcher-osx-${architecture}-package"
            fileToUpload = 'PharoLauncher*-' + fileNameArchSuffix(architecture) + '.dmg'
            upload(fileToUpload, uploadDirectoryName())
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
  (architecture == '32') ? return 'x86'
  return  (architecture == '64') ? 'x64' : architecture
}

def isPullRequest() {
  return env.CHANGE_ID != null
}

def uploadDirectoryName() {
  if (isRelease)
    return version
  else
    return 'bleedingEdge'
}

String getVersion() {
  node('linux') {
    commit = getCommitHash()
    if (commit) {
        desc = sh(script: "git describe --tags --always ${commit}", returnStdout: true)?.trim()
        if (isTag(desc)) {
            isRelease = true
            return desc
        }
    }
    return commit
  }
}

def getCommitHash(){
  //To ensure a clean build we delete the directory, checkout from scm and get the commit hash all from scratch
  deleteDir()
  checkout scm
  return sh(returnStdout: true, script: 'git log -1 --format="%h"').trim()
}

@NonCPS
boolean isTag(String desc) {
    // We search for a commitish pattern
    // [0-9A-Fa-f] => an hexadecimal
    // {6,} => 6 or more time
    // match instance of Matcher, !match => pattern not found
    match = desc =~ /[0-9A-Fa-f]{6,}$/
    result = !match
    match = null // prevent serialisation
    return result

    /* Test cases for the pattern (only last 2 should be true):
    println isTag('12c26ce')
    println isTag('8a5e1bcbe8e335a031a0458ad60382aeb0cadefc')
    println isTag('1.6-17-g12c26ce')
    println isTag('1.6')
    println isTag('1.4.1') */
}
