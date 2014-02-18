private
metaFromDirectory: aDirectory
	| myMeta |
	
	myMeta := Dictionary new.
	(aDirectory filesMatching: PhLAbstractTemplate metaInfoFileName)
		do: [ :metaFile | 
			metaFile readStreamDo: [ :stream | 
				[ myMeta addAll: (STON fromStream: stream)  . 1/0 ]
					on: Error
					do: [ PhLUIInformation new 
							message: ('PharoLauncher error: meta info {1}' format: {  metaFile asString }) ;
							inform ] ] ].
	^ myMeta