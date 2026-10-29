Extension { #name : 'SpMorphicActionBarAdapter' }

{ #category : '*PharoLauncher-SpecPatches-GridColumnSizing' }
SpMorphicActionBarAdapter >> addModelTo: aMorph [

	self flag: #TODO. "Maybe validate they are just buttons inside?"
	(self model items at: #start ifAbsent: [ #() ]) do: [ :each |
		aMorph addItemLeft: (self buildActionButton: each) ].
	self model centerPresenter ifNotNil: [ :aPresenter |
		aMorph addItemCenter: aPresenter build ].
	(self model items at: #end ifAbsent: [ #() ]) reverseDo: [ :each |
		aMorph addItemRight: (self buildActionButton: each) ]
]
