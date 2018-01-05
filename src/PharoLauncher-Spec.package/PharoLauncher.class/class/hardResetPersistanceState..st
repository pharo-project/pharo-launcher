settings
hardResetPersistanceState: isClickedFromSettings 
	|packages|
	
	isClickedFromSettings ifFalse: [ ^ self ]. "Important: this code should not be run when loading stored preferences, else PharoLauncher deployment mode is set to not deployed!"
	
	SystemWindow allSubInstances do:[:w| w delete].
	self inform: 'PharoLauncher state reset'.
	World doOneCycle.
	500 milliSeconds wait. "To help user perception that *something* was reset"
		
	packages := RPackageOrganizer default packages select:[:p| 
		(p name includesSubstring: 'PharoLauncher') ].
	packages do: [:p| p definedClasses do:[:class| 
		class classPool keys do: [ :k | class classPool at: k put: nil ] ]].

	self open.