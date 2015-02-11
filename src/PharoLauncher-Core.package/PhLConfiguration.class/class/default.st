accessing
default
	^ Default
		ifNil: [ 
			Default := self new
				initializeOnFile: self configurationFile;
				yourself ]