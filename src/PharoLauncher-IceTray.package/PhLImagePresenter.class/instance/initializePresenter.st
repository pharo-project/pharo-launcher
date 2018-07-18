initialization
initializePresenter
	
"	self submitButton action: [self submit].	
	self restoreButton action: [self restore].
	
	self number1Input whenTextChanged: [ 
		| receivedText newText |
		receivedText := self number1Input text asString.
		newText := receivedText select: [ :aCharacter | aCharacter isDigit ].
		newText = receivedText ifFalse: [ 
			self number1Input textHolder rawValue: newText.
			self number1Input textHolder valueChanged: newText] ]"