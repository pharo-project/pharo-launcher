accessing
imageFormatNumber
	^ imageFormatNumber
		ifNil: [ imageFormatNumber := self class imageFormatNumberFromFile: imageFile ]