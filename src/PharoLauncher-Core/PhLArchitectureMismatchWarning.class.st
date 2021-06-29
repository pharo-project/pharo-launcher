"
Warning raised when PharoLauncher architecture (image / VM) does not match the image (and by consequence the VM to run it) architecture.
e.g. raised when PharoLauncher 64-bit tries to run a 32-bit image (possibly missing libraries)
"
Class {
	#name : #PhLArchitectureMismatchWarning,
	#superclass : #Warning,
	#instVars : [
		'launcherArchitecture',
		'imageArchitecture'
	],
	#category : #'PharoLauncher-Core-Download'
}

{ #category : #signalling }
PhLArchitectureMismatchWarning class >> signalLauncherArch: launcherArchitecture imageArch: imageArchitecure [ 
	^ self new
		initializeWith: launcherArchitecture imageArch: imageArchitecure;
		signal
]

{ #category : #initialization }
PhLArchitectureMismatchWarning >> initializeWith: launcherArch imageArch: imageArch [
	launcherArchitecture := launcherArch.
	imageArchitecture := imageArch.
]

{ #category : #accessing }
PhLArchitectureMismatchWarning >> longDescription [
	^ String streamContents: [ :stream |
		stream
			nextPutAll: 'Warning! You are trying to launch a ';
			nextPutAll: imageArchitecture;
			nextPutAll: ' image requiring a ';
			nextPutAll: imageArchitecture;
			nextPutAll: ' VM.';
			nextPut: Character cr;
			nextPutAll: 'Your Pharo Launcher architecture is ';
			nextPutAll: launcherArchitecture;
			nextPutAll: '. You may need to install additional librairies to your system.';
			nextPut: Character cr;
			nextPutAll: 'See https://pharo.org/gnu-linux-installation for more information.' ]
]

{ #category : #accessing }
PhLArchitectureMismatchWarning >> name [
	^ 'Architecture Mismatch! Continue?'
]
