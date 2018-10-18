"
Open a dialog to show the user some basic information about the selected image.
"
Class {
	#name : #PhLShowImageInfoCommand,
	#superclass : #PhLImageCommand,
	#category : 'PharoLauncher-Core-Commands'
}

{ #category : #action }
PhLShowImageInfoCommand class >> group [
	^ 3
]

{ #category : #accessing }
PhLShowImageInfoCommand class >> icon [
	^ self iconNamed: #smallInfoIcon
]

{ #category : #accessing }
PhLShowImageInfoCommand class >> title [
	^ 'Image Details'
]

{ #category : #action }
PhLShowImageInfoCommand >> execute [
	self model newInformation 
		message: self model singleImage summaryInfo; 
		denyWithTitle: 'Image Details'

]
