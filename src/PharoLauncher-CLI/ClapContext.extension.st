Extension { #name : #ClapContext }

{ #category : #'*PharoLauncher-CLI' }
ClapContext >> initialize [
	arguments := #().
	obeyingExits := false.
	parsedArguments := Dictionary new.

	"initialize default notification center with proper streams available on context object"
	PhLNotificationCenter default outStream: self stdout.
	PhLNotificationCenter default errorStream: self stderr.

]

{ #category : #'*PharoLauncher-CLI' }
ClapContext >> pharoLauncherModel [
	^ PharoLauncherCLIModel new
]
