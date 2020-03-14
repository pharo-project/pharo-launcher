Class {
	#name : #PhErrorDialogWindow,
	#superclass : #ErrorDialogWindow,
	#instVars : [
		'debugPressed'
	],
	#category : #'PharoLauncher-Core-Exceptions'
}

{ #category : #'as yet unclassified' }
PhErrorDialogWindow >> debugPressed [
	^ debugPressed 
]

{ #category : #'as yet unclassified' }
PhErrorDialogWindow >> initialize [ 
	super initialize.
	debugPressed := false
]

{ #category : #'instance creation' }
PhErrorDialogWindow >> newButtons [
	"Answer new buttons as appropriate."
	^{self newDebugButton . self newOKButton isDefault: true}
]

{ #category : #'instance creation' }
PhErrorDialogWindow >> newDebugButton [
	^ (self theme
			newButtonIn: self
			for: self
			getState: nil
			action: #pressedDebug 
			arguments: nil
			getEnabled: nil
			label: '  Debug...  ' translated
			help: 'Debug the error' translated) 
		hResizing: #rigid;
		vResizing: #rigid
]

{ #category : #'as yet unclassified' }
PhErrorDialogWindow >> newTextMorph [
	"For web links embedded in Text to be clickable, TextMorph needs to be UNLOCKED,
	 but that also makes the text editable. To make the text uneditable, TextMorph
	 needs to DISABLED.  However TextMorph>>enabled awfully inextricably links the two.
	 These concerns are separated in PhLWebLinkTextMorph" 
	
	^ PhLWebLinkTextMorph new copyFrom: super newTextMorph 
]

{ #category : #'as yet unclassified' }
PhErrorDialogWindow >> pressedDebug [
	debugPressed := true.
	self delete.
]

{ #category : #'as yet unclassified' }
PhErrorDialogWindow >> textAsFormatted: aText [
	"Adapted from MEssageDialogWindow>>text: but don't force colour so that 
	 web link standard blue text can embed within body of black text"
	|t|
	t := aText copy
		addAttribute: TextAlignment centered.
	self textMorph newContents: t

]
