"
This class gives a real Pharo image that can be used for tests (for example launch).
"
Class {
	#name : #PhLTestImageProvider,
	#superclass : #Object,
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #copying }
PhLTestImageProvider >> copyCurrentImageTo: targetFolder [
	| image imagePath |
	imagePath := targetFolder / FileLocator image basenameWithoutExtension / FileLocator image basename. 
	imagePath asFileReference parent ensureCreateDirectory. 
	FileLocator image copyTo: imagePath .
	image := PhLImage location: imagePath.
	(imagePath asFileReference parent / (FileLocator image basenameWithoutExtension , '.changes')) ensureCreateFile. 
	image versionFile 
		writeStreamDo: [ :stream | 
			SystemVersion current major asString putOn: stream.
			SystemVersion current minor asString putOn: stream ].
	image addLaunchConfiguration: 
		(image defaultLaunchConfiguration 
			vmArguments: #('--headless');  "be able to run test without X session"
			imageArguments: #('--no-quit');
			yourself).
	^ image
]
