private
templateFor: anImage
	| metainf metainfFile |
	
	metainfFile := anImage file parent / (PhLAbstractTemplate metaInfoFileName).
	metainfFile readStreamDo: [ :stream | metainf := STON fromStream: stream ].
	^ metainf at: #template.