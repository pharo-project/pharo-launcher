Extension { #name : #FileReference }

{ #category : #'*PharoLauncher-100Compatibility' }
FileReference >> asFileLocatorOrReference [
	filesystem isMemoryFileSystem ifTrue: [ ^ self "no convertion for memory file system" ].
	
	^ self path asFileLocatorOrReference
]
