private
imageVersionDeterminationScriptPath
	| file |
	file := self vmStore parent / 'pharo-version.st'.
	file exists 
		ifFalse: [ | source|
			source := (self class >> #imageVersionDeterminationScript) sourceCode
				allButFirst: #imageVersionDeterminationScript size. "remove method name"
			file writeStreamDo: [ :stream | stream << source ] ].
	^ file fullName 