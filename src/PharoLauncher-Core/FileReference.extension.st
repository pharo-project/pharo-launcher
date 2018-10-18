Extension { #name : #FileReference }

{ #category : #'*PharoLauncher-Core' }
FileReference class >> fromSton: stonReader [
	
	^ stonReader parseListSingleton asFileReference
]

{ #category : #'*PharoLauncher-Core' }
FileReference >> stonOn: stonWriter [

	stonWriter writeString: self fullName
]
