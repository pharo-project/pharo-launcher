"
Error raised when trying to run a 32-bit image whereas the underlying Operating System does not support 32-bit applications.
"
Class {
	#name : #PhLArchitectureError,
	#superclass : #PhLLaunchError,
	#instVars : [
		'description',
		'configuration'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #signalling }
PhLArchitectureError class >> signalConfiguration: aPhLConfiguration [
	^ self new 
		configuration: aPhLConfiguration;
		signal
]

{ #category : #signalling }
PhLArchitectureError class >> signalImageOsNon32bitCompliant: anImage [
	^ self new 
		process: nil image: anImage;
		osNon32bitCompliantDescription;
		signal
]

{ #category : #initialization }
PhLArchitectureError >> configuration: aPhLLaunchConfiguration [

	configuration := aPhLLaunchConfiguration
]

{ #category : #accessing }
PhLArchitectureError >> longDescription [
	^ description 
		ifNil: [ 'Cannot run VM ''{1}'' on this system!' format: { configuration vm id } ]
]

{ #category : #accessing }
PhLArchitectureError >> name [
	^ 'Architecture error'
]

{ #category : #accessing }
PhLArchitectureError >> osNon32bitCompliantDescription [
	description := ('Cannot run {1} image!' format: { image name }), 
		String cr, 
		'This image requires a 32-bit VM to run and 32-bit applications are not supported on this Operating System!'
]
