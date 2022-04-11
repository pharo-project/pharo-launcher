Extension { #name : #VTermOutputDriver }

{ #category : #'*PharoLauncher-CLI' }
VTermOutputDriver >> newLine [

	self nextPutAll: OSPlatform current lineEnding
]
