Extension { #name : #PhLImage }

{ #category : #'*PharoLauncher-CLI' }
PhLImage >> cliPrintOn: anOutputStream [
	anOutputStream
		nextPutAll: self name;
		tab;
		nextPutAll: 'architecture: ';
		nextPutAll: self architecture.
]

{ #category : #'*PharoLauncher-CLI' }
PhLImage class >> listPrintAttributeBlocks [
	
	^ {[:image | image name]. [:image | image architecture]. [:image | image pharoVersion]. [:image | image lastModification].}
]

{ #category : #'*PharoLauncher-CLI' }
PhLImage class >> listPrintAttributeLabels [
	
	^ #('Name' 'Architecture' 'Pharo version' 'Last modified')
]

{ #category : #'*PharoLauncher-CLI' }
PhLImage >> listPrintAttributes [
	
	^ #(#name #architecture #pharoVersion #lastModification)
]
