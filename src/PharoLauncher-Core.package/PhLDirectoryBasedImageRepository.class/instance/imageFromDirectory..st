private
imageFromDirectory: aDirectory
	"Create an instance of PhLImage representing the Pharo image in aDirectory"

	| imageName imageFiles changeFiles meta |
	imageName := aDirectory basename.
	imageFiles := aDirectory filesMatching: imageName , '.image'.
	changeFiles := aDirectory filesMatching: imageName , '.changes'.
	
	meta := Dictionary new.
	(aDirectory filesMatching: PhLAbstractTemplate metaInfoFileName) do: 
	[ 	:metaFile | metaFile readStreamDo: 
		[ 	:stream | [ meta addAll: (STON fromStream: stream) ] on: Error do: [ Transcript crShow: 'PharoLauncher error: meta info ' , metaFile asString ]. 
		]
	].

	^ (imageFiles size ~= 1 or: [ changeFiles size ~= 1 ])
		ifTrue: [ nil ]
		ifFalse: [ PhLImage location: imageFiles first meta: meta ]