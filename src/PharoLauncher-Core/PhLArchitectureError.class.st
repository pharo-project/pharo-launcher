"
Error raised when trying to run a 32-bit image whereas the underlying Operating System does not support 32-bit applications.
"
Class {
	#name : #PhLArchitectureError,
	#superclass : #PhLLaunchError,
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #signalling }
PhLArchitectureError class >> signalImage: anImage [
	^ self new 
		process: nil image: anImage;
		signal
]

{ #category : #accessing }
PhLArchitectureError >> longDescription [
	^ ('Cannot run {1} image!' format: { image name }), 
		String cr, 
		'This image requires a 32-bit VM to run and 32-bit applications are not supported on this Operating System!'
]

{ #category : #accessing }
PhLArchitectureError >> name [
	^ 'Architecture error'
]
