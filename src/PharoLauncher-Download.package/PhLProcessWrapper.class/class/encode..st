encoding
encode: aCommand

	| encoded |
	
	(aCommand isWideString and: [ Smalltalk os isWindows ])
		ifTrue: [ PhLNotSupportedCharacterError signal ].

	encoded := Smalltalk os isWindows
		ifTrue: [ aCommand ]
	 	ifFalse: [ aCommand utf8Encoded asString ].
	^ encoded