"
This is sample image launch configuration mock to be used just in tests (bypassing PhLLaunchConfiguration object)
"
Class {
	#name : 'PhLLaunchConfigurationMock',
	#superclass : 'Object',
	#category : 'PharoLauncher-CLI-Tests-Mocks',
	#package : 'PharoLauncher-CLI-Tests',
	#tag : 'Mocks'
}

{ #category : 'mock' }
PhLLaunchConfigurationMock >> commandString [

	^ 'Mock image sample command'
]

{ #category : 'settings' }
PhLLaunchConfigurationMock >> workingDirectory: aFileReference [ 
	
	"ignore"
]
