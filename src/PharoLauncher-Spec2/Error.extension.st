Extension { #name : #Error }

{ #category : #'*PharoLauncher-Spec2' }
Error >> defaultAction [
	"No one has handled this error, but now give them a chance to decide how to debug it.  If none handle this either then open debugger (see UnhandedError-defaultAction)"
	PharoLauncherApplication isDeployed
		ifTrue: [ (PhLErrorDialogPresenter on: self) openDialogWithSpec ]
		ifFalse: [ UnhandledError signalForException: self ]
]
