private
classesClassVariablesToClean
	"self classesClassVariablesToClean"
	^self classesWithClassVariables 
		removeKey: ConfigurationOfPharoLauncher ;
		removeKey: PhLStartupManager ;
		yourself