"
Copy the command used to launch the selected image to the system clipboard.
"
Class {
	#name : #PhLCopyLaunchCommand,
	#superclass : #PhLImageCommand2,
	#category : #'PharoLauncher-Core-Commands2'
}

{ #category : #executing }
PhLCopyLaunchCommand >> execute [
	Clipboard clipboardText: 
		(self imagesPresenter singleImage launchCommandStringWithSettings: false)
]
