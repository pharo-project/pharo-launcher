Extension { #name : #DateAndTime }

{ #category : #'*PharoLauncher-CLI' }
DateAndTime >> asLocalStringYMDHMS [
	^ self asLocal asStringYMDHMS
]

{ #category : #'*PharoLauncher-CLI' }
DateAndTime >> asStringYMDHMS [
	^ String streamContents: [ :aStream |
		self printYMDOn: aStream.
		aStream nextPut: Character space.
		self printHMSOn: aStream ]
]
