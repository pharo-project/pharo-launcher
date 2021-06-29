Extension { #name : #WriteStream }

{ #category : #'*PharoLauncher-CLI-Tests' }
WriteStream >> newLine [
	self nextPutAll: OSPlatform current lineEnding
]
