Extension { #name : #FileReference }

{ #category : #'*PharoLauncher-Pharo9ToRemove-FileLocator' }
FileReference >> asFileLocatorOrReference [
	filesystem isMemoryFileSystem ifTrue: [ ^ self "no convertion for memory file system" ].
	
	^ self path asFileLocatorOrReference
]
