"
Copy the command used to launch the selected image to the system clipboard.
"
Class {
	#name : #PhLCopyLaunchCommand,
	#superclass : #PhLImageCommand,
	#category : #'PharoLauncher-Core-Commands'
}

{ #category : #executing }
PhLCopyLaunchCommand >> execute [
	Clipboard clipboardText: 
		self imagesPresenter singleImage defaultLaunchConfiguration commandString
]
