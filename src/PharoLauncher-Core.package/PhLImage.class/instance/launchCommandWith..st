action
launchCommandWith: aFullPathString
	| command vmCommand imagePath |
	vmCommand := aFullPathString isEmpty
		ifTrue: [ Smalltalk vm fullPath asString ]
		ifFalse: [ aFullPathString ].
	imagePath := file pathString.
	command := $" asString , vmCommand , '"  "' , imagePath , '"'.
	^ command