Extension { #name : #STON }

{ #category : #'*PharoLauncher-STON-extension' }
STON class >> reader [
	^ STONReaderWithMapping new
]

{ #category : #'*PharoLauncher-STON-extension' }
STON class >> writer [
	^ STONWriterWithMapping new
]
