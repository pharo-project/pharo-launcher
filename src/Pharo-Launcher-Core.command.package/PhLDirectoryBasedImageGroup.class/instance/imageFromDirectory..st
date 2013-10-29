private
imageFromDirectory: aDirectory
	"Create an instance of PhLImage representing the Pharo image in aDirectory"

	| imageName imageFiles changeFiles |
	imageName := aDirectory basename.
	imageFiles := aDirectory filesMatching: imageName , '.image'.
	changeFiles := aDirectory filesMatching: imageName , '.changes'.
	^ (imageFiles size ~= 1 or: [ changeFiles size ~= 1 ])
		ifTrue: [ nil ]
		ifFalse: [ PhLImage location: imageFiles first ]