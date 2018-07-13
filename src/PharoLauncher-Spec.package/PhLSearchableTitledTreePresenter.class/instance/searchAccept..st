private - filtering
searchAccept: aString

	 aString isEmptyOrNil
		ifTrue: [ self filterPattern: nil ]
		ifFalse: [ self filterPattern: 
					([ aString asRegexIgnoringCase ] on: RegexSyntaxError do: [ aString ])].
	self refresh			
 