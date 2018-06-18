action
importImageNamed: imagePath andSiblingFilesto: targetName
	| sourceDirectory |
	imagePath asFileReference exists ifFalse: [ ^ self ].
	
	sourceDirectory := imagePath asFileReference parent.
	self moveImage: sourceDirectory to: targetName