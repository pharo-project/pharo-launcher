Extension { #name : #ZnUrl }

{ #category : #'*PharoLauncher-80Compatibility' }
ZnUrl class >> fromSton: stonReader [
	^ [ self fromString: stonReader parseListSingleton ]
		on: STONReaderError
		do: [ super fromSton: stonReader ]
]
