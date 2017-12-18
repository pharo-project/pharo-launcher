properties([parameters([
	string(name: 'VERSION', defaultValue: 'bleedingEdge', description: 'Which Pharo Launcher version to build?'),
	string(name: 'PHARO', defaultValue: '61', description: 'Which Pharo image version to use?'),
	string(name: 'VM', defaultValue: 'vm', description: 'Which Pharo vm to use?')
])])

node('linux') {

    stage('Build') {
    	cleanWs()
    	checkout scm
    	dir('pharo-build-scripts') {
    		git('https://github.com/pharo-project/pharo-build-scripts.git')
    	}
        sh "./build.sh prepare ${params.VERSION}"
        archiveArtifacts artifacts: 'PharoLauncher.image, PharoLauncher.changes, pharo, pharo-vm', fingerprint: true
    }

    stage('Test') {
    	cleanWs()
    	copyImage()
    	copyVm()
    	sh 'build.sh test'
        junit '*.xml'
    }

    stage('Packaging-developer') {
    	cleanWs()
    	copyImage()
    	copyVm()
    	sh 'build.sh developer'
    	archiveArtifacts artifacts: 'PharoLauncher-developer.zip, version.txt', fingerprint: true
    }

    stage('Packaging-user') {
    	cleanWs()
    	copyImage()
    	copyVm()
    	sh 'build.sh developer'
    	archiveArtifacts artifacts: 'PharoLauncher-user-*.zip, Pharo-mac.zip, Pharo-win.zip, Pharo-linux.zip, version.txt', fingerprint: true
    }

    stage('Deploy') {
		if (currentBuild.result == null || currentBuild.result == 'SUCCESS') { 
            sh 'echo publish'
        }
    }
}

def copyVm() {
	// Copy vm files from the 'Build' stage to the current stage
	sh 'cp ../Build/pharo .
    cp -R ../Build/pharo-vm .'
}

def copyImage() {
	// Copy image files from the 'Build' stage to the current stage
  	sh 'cp ../Build/PharoLauncher.image .
  	cp ../Build/PharoLauncher.changes .'
}