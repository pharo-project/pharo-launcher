"
Launcher update checker for test purposes: I answer the latest version I was given, without asking the server.
"
Class {
	#name : 'PhLTestLauncherUpdateChecker',
	#superclass : 'PhLLauncherUpdateChecker',
	#instVars : [
		'latestVersion'
	],
	#category : 'PharoLauncher-Tests-SpecUI',
	#package : 'PharoLauncher-Tests-SpecUI'
}

{ #category : 'instance creation' }
PhLTestLauncherUpdateChecker class >> latestVersion: aString [

	^ self new
		  setLatestVersion: aString;
		  yourself
]

{ #category : 'testing' }
PhLTestLauncherUpdateChecker >> isUpdateAvailable [

	^ latestVersion notNil
]

{ #category : 'accessing' }
PhLTestLauncherUpdateChecker >> latestVersion [

	^ latestVersion
]

{ #category : 'initialization' }
PhLTestLauncherUpdateChecker >> setLatestVersion: aString [

	latestVersion := aString ifNotNil: [ PhLLauncherVersion fromString: aString ]
]
