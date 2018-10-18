Extension { #name : #FileSystemResolver }

{ #category : #'*PharoLauncher-Env' }
FileSystemResolver >> resolveString: aString [
	| fs |
	fs := FileSystem disk.
	^ FileReference 
		fileSystem: fs 
		path: (fs pathFromString: aString)
]
