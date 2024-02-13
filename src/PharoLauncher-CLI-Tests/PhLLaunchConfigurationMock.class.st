"
This is sample image launch configuration mock to be used just in tests (bypassing PhLLaunchConfiguration object)
"
Class {
	#name : #PhLLaunchConfigurationMock,
	#superclass : #Object,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #mock }
PhLLaunchConfigurationMock >> commandString [

	^ 'Mock image sample command'
]

{ #category : #settings }
PhLLaunchConfigurationMock >> workingDirectory: aFileReference [ 
	
	"ignore"
]
