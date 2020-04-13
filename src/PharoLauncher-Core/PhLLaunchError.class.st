"
Error raised when the launch of an image failed!
"
Class {
	#name : #PhLLaunchError,
	#superclass : #PhLError,
	#instVars : [
		'image',
		'process'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #signalling }
PhLLaunchError class >> signalProcess: aProcess image: anImage [
	^ self new 
		process: aProcess image: anImage;
		signal
]

{ #category : #action }
PhLLaunchError >> defaultAction [ 
	PhLUIInformation new
		message: self longDescription;
		alert
]

{ #category : #accessing }
PhLLaunchError >> longDescription [
	^ ('An error occured while launching {1} image' format: image name), 
		String cr, process stderrString
]

{ #category : #accessing }
PhLLaunchError >> name [
	^ 'Launch error'
]

{ #category : #initialization }
PhLLaunchError >> process: aPhLProcessWrapper image: aPhLImage [ 
	process := aPhLProcessWrapper.
	image := aPhLImage.
]
