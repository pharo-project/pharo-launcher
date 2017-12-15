node {
    stage('Build') {
    	cleanWs()
    	checkout scm

        sh 'build.sh prepare'
    }

    stage('Test') {
        sh 'build.sh test'
        junit '*.xml'
    }

    stage('Packaging-developer') {
    	sh 'build.sh developer'
    	archiveArtifacts artifacts: 'PharoLauncher-developer.zip, version.txt', fingerprint: true
    }

    stage('Packaging-user') {
    	sh 'build.sh developer'
    	archiveArtifacts artifacts: 'PharoLauncher-user-*.zip, Pharo-mac.zip, Pharo-win.zip, Pharo-linux.zip, version.txt', fingerprint: true
    }

    stage('Deploy') {
		if (currentBuild.result == null || currentBuild.result == 'SUCCESS') { 
            sh 'echo publish'
        }
    }
}