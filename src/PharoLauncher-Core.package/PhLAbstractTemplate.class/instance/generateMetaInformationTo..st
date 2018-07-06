actions
generateMetaInformationTo: aDirectory
	| metainf |
	
	metainf := Dictionary new.
	metainf at: 'template' put: self.
	
	aDirectory / (PhLAbstractTemplate metaInfoFileName) 
		writeStreamDo: [ : stream | stream nextPutAll: (STON toString: metainf) ]