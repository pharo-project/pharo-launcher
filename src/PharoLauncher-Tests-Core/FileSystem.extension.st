Extension { #name : 'FileSystem' }

{ #category : '*PharoLauncher-Tests-Core' }
FileSystem class >> identifiableMemory: aName [
	^ self store: (IdentifiableMemoryStore named: aName)
]
