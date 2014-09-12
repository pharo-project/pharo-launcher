printing
descriptionForImage: anImage
	| descriptionFile |
	descriptionFile := (self directoryForImageNamed: anImage name) / 'description.txt'.
	^ descriptionFile exists
		ifFalse: [ descriptionFile fullName, ' does not exist' ]
		ifTrue: [ 
			[ descriptionFile readStream nextLine ]
				on: Error
				do: [ descriptionFile fullName, ' is not readable' ] ]