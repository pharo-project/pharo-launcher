querying
imageFormatNumberFromFile: anImagePath
	| imageFile |
	imageFile := anImagePath asFileReference.
	imageFile exists ifFalse: [
		self error: imageFile fullName, ' does not exist.' ].
	^ imageFile binaryReadStreamDo: [ :stream | self imageFormatNumberFromStream: stream ].
