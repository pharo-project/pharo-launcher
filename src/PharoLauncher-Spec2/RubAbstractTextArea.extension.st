Extension { #name : #RubAbstractTextArea }

{ #category : #'*PharoLauncher-Spec2' }
RubAbstractTextArea >> themeChanged [ 
	
	self flag: 'to delete once integrated into Pharo'.
	self color: self theme backgroundColor.
	super themeChanged
]
