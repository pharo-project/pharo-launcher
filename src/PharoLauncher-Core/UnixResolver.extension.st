Extension { #name : #UnixResolver }

{ #category : #'*PharoLauncher-Core' }
UnixResolver >> launcherUserFilesLocation [
	"Documents folder is not a standard on Unix. Put files in the $HOME directory"
	^ self home / 'Pharo'
]

{ #category : #'*PharoLauncher-Core' }
UnixResolver >> vmExecutableName [
	^ 'pharo'
]
