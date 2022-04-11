Extension { #name : #ClapContext }

{ #category : #'*PharoLauncher-80Compatibility' }
ClapContext class >> pragmaCommands [
	^ (PragmaCollector filter: [:prg | prg selector = #commandline]) reset
		collect: [ :pragma |
			| theClass theSelector |
			theClass := pragma method methodClass.
			theSelector := pragma method selector.
			self assert: [ theSelector isUnary ].
			
			theClass instanceSide
				perform: theSelector ]
]
