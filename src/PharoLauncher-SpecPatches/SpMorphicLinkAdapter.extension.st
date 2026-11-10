Extension { #name : 'SpMorphicLinkAdapter' }

{ #category : '*PharoLauncher-SpecPatches-LinkHelp' }
SpMorphicLinkAdapter >> buildWidget [
	"Since Pharo does not yet have a real morph for URL, I create my own. Maybe later we will have real links in Morphic?"

	| aMorph |
	aMorph := StringMorph new
		          contents: self getLabelText;
		          dragEnabled: self dragEnabled;
		          dropEnabled: self dropEnabled;
		          vResizing: #shrinkWrap;
		          hResizing: #spaceFill;
		          setBalloonText: self getHelpText;
		          color: self urlColor;
		          on: #mouseEnter send: #mouseEnter:from: to: self;
		          on: #mouseLeave send: #mouseLeave:from: to: self;
		          on: #mouseDown send: #mouseDown:from: to: self;
		          on: #mouseUp send: #mouseUp:from: to: self;
		          yourself.

	self presenter whenLabelChangedDo: [ :newLabel | 
		aMorph contents: (newLabel ifNotNil: [ :aString | 
				 aString localizedForPresenter: self presenter ]) ].
	self presenter whenHelpChangedDo: [ aMorph setBalloonText: self getHelpText ].

	^ aMorph
]

{ #category : '*PharoLauncher-SpecPatches-LinkHelp' }
SpMorphicLinkAdapter >> getHelpText [
	"An empty help would display an empty balloon"

	^ self presenter help ifNotNil: [ :aString |
		  aString ifNotEmpty: [ aString localizedForPresenter: self presenter ] ifEmpty: [ nil ] ]
]
