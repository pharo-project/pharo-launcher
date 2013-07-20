as yet unclassified
openLauncher
	| launcher |
	self flag: 'TODO: remove the next 3 lines when Spec is fixed'.
	SpecBinder initializeBindings.
	SpecInterpreter hardResetBindings.
	BindingsHolder classVarNamed: #Bindings put: nil.
	launcher := PharoLauncher open.
	launcher window makeUnclosable; sticky: true