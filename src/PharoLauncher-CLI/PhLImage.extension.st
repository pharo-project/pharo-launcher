Extension { #name : #PhLImage }

{ #category : #'*PharoLauncher-CLI' }
PhLImage class >> extendedListPrintAttributeBlocks [
	"this is used to dump extended image information"
	|aColl|
	aColl := OrderedCollection newFrom: self listPrintAttributeBlocks.
	aColl
		addAll:
			{[:image | image description ].
			[ :image | image originTemplateName ].
			[ :image | image originTemplateUrl ].
			[ :image | image location ]}.
	^ aColl
]

{ #category : #'*PharoLauncher-CLI' }
PhLImage class >> extendedListPrintAttributeLabels [
	"this is used to dump extended image information"

	| labels |
	labels := OrderedCollection newFrom: self listPrintAttributeLabels.
	labels addAll: #('Description' 'Origin template' 'Template URL' 'Local path').
	^ labels
]

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
