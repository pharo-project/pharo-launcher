action
request
	| answer |
	[ answer := UIManager default request: title initialAnswer: initialAnswer ]
		doWhileTrue: [ answer isNotNil and: [ (validationBlock value: answer) not ] ].
		"answer is nil when the user press cancels. That's a possible answer we have to accept."
	^ answer