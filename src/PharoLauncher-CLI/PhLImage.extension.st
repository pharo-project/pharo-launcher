Extension { #name : #PhLImage }

{ #category : #'*PharoLauncher-CLI' }
PhLImage class >> listPrintAttributeBlocks [
	
	^ {[:image | image name]. [:image | image architecture]. [:image | image pharoVersion]. [:image | image lastModification asLocalStringYMDHMS ].}
]

{ #category : #'*PharoLauncher-CLI' }
PhLImage class >> listPrintAttributeLabels [
	
	^ #('Name' 'Architecture' 'Pharo version' 'Last modified')
]

{ #category : #'*PharoLauncher-CLI' }
PhLImage >> listPrintAttributes [
	
	^ #(#name #architecture #pharoVersion #lastModification)
]
