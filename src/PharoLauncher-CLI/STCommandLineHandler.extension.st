Extension { #name : #STCommandLineHandler }

{ #category : #'*PharoLauncher-CLI' }
STCommandLineHandler class >> isResponsibleFor: aCommandLine [
	" for the pharo launcher if we pass a script with st option the command line handler goes before clap "
	^ false
]
