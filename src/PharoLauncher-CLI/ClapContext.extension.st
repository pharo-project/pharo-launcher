Extension { #name : #ClapContext }

{ #category : #'*PharoLauncher-CLI' }
ClapContext >> initializeLauncherNotificationCenter [
	"initialize default notification center with proper streams available on context object.
	This is called just after #initialize method through a meta link defined in 
	PhLNotificationCenter class>>#beInitializedByClapContextStreams"
	
	PhLNotificationCenter default outStream: self stdout.
	PhLNotificationCenter default errorStream: self stderr.

]

{ #category : #'*PharoLauncher-CLI' }
ClapContext >> pharoLauncherModel [
	^ PharoLauncherCLIModel new
]
