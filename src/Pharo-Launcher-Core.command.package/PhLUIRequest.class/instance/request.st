action
request
	| answer |
	[answer := UIManager default request: title initialAnswer: initialAnswer]
	doWhileTrue: [ answer isEmptyOrNil or: [(validationBlock value: answer) not] ].
	^ answer