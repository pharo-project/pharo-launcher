Extension { #name : #STCommandLineHandler }

{ #category : #'*PharoLauncher-CLI' }
STCommandLineHandler class >> isResponsibleFor: aCommandLine [
	" for the pharo launcher if we pass a script with st option the command line handler goes before clap "
	(aCommandLine includesSubCommand: ClapCommandLineHandler commandName) ifTrue: [ ^ false ].
	
	"This handler is reponsible only for .st files"
	(aCommandLine hasFileWithExtension: '.st')
 "true"		ifTrue: [ ^ true ].
	^ super isResponsibleFor: aCommandLine
]
