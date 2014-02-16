private
metaFromDirectory: aDirectory
	| meta |
	
	meta := Dictionary new.
	(aDirectory filesMatching: PhLAbstractTemplate metaInfoFileName)
		do: [ :metaFile | 
			metaFile readStreamDo: [ :stream | 
				[ meta addAll: (STON fromStream: stream) ]
					on: Error
					do: [ Transcript crShow: 'PharoLauncher error: meta info ' , metaFile asString ] ] ].
	^ meta