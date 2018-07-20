accessing
displayStringOf: aDateAndTime
	^ (String
		streamContents: [ :s | 
			s
				nextPutAll: aDateAndTime asDate yyyymmdd;
				space.
			aDateAndTime asTime print24: true on: s ]) asText