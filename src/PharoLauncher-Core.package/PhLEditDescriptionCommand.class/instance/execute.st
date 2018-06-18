action
execute
	| description |
	description := self imageDescription.
	description := UIManager default
		multiLineRequest: 'Description of the image'
		initialAnswer: description
		answerHeight: 200.
	description ifNil: [ ^ self ].	"Edition cancelled"
	self imageDescription: description