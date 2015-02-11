as yet unclassified
imageDirectory
	^ dictionary at: #imageDirectory ifAbsent: [ FileLocator documents / 'pharo' / 'launcher' ]