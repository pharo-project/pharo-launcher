private
metaFromDirectory: aDirectory
	| myMeta |
	
	myMeta := Dictionary new.
	(aDirectory filesMatching: PhLAbstractTemplate metaInfoFileName)
		do: [ :metaFile | 
			metaFile readStreamDo: [ :stream | 
				[ myMeta addAll: (STON fromStream: stream) ]
					on: Error
					do: [ Transcript crShow: 'PharoLauncher error: meta info ' , metaFile asString ] ] ].
	^ myMeta