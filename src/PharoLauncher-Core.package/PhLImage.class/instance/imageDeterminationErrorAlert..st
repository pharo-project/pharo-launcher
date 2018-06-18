error handling
imageDeterminationErrorAlert: error
	^ UIManager default
		alert: error longDescription
		title: error name
		configure: [ :morph | (morph findDeeplyA: TextMorph) unlock ]