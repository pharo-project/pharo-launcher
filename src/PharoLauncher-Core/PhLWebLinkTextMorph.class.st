Class {
	#name : #PhLWebLinkTextMorph,
	#superclass : #TextMorph,
	#category : #'PharoLauncher-Core-Exceptions'
}

{ #category : #testing }
PhLWebLinkTextMorph >> enabled [
	"For web links embedded in Text to be clickable, TextMorph needs to be UNLOCKED,
	 but that also makes the text editable. To make the text uneditable, TextMorph
	 needs to DISABLED.  However TextMorph>>enabled awfully inextricably links the two.
	 So separate the concerns here" 
	^false
]

{ #category : #testing }
PhLWebLinkTextMorph >> isLocked [
	"For web links embedded in Text to be clickable, TextMorph needs to be UNLOCKED,
	 but that also makes the text editable. To make the text uneditable, TextMorph
	 needs to DISABLED.  However TextMorph>>enabled awfully inextricably links the two.
	 So separate the concerns here" 
	^false
]
