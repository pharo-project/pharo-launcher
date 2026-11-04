"
A minimal image for test purposes: launching me evaluates a block.
"
Class {
	#name : 'PhLTestLaunchableImage',
	#superclass : 'Object',
	#instVars : [
		'launchBlock'
	],
	#category : 'PharoLauncher-Tests-Commands',
	#package : 'PharoLauncher-Tests-Commands'
}

{ #category : 'accessing' }
PhLTestLaunchableImage >> ensurePharoVersion [
	"nothing to do"
]

{ #category : 'accessing' }
PhLTestLaunchableImage >> launchBlock: aBlock [
	launchBlock := aBlock
]

{ #category : 'action' }
PhLTestLaunchableImage >> launchWithConfiguration: aPhLLaunchConfiguration [
	^ launchBlock value
]
