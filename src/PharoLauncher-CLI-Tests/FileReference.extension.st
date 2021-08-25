Extension { #name : #FileReference }

{ #category : #'*PharoLauncher-CLI-Tests' }
FileReference >> stonContainSubObjects [
	^ self fileSystem isStonReference 
]
