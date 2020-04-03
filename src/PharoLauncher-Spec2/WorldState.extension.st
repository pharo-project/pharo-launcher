Extension { #name : #WorldState }

{ #category : #'*PharoLauncher-Spec2' }
WorldState class >> quitSession [
	self flag: 'TODO'.
	"Since UserManager is now over, there is no clean way to avoid warning when we just ask to quit the image. More general, there should be a way to have an image in read/only mode" 
	PhLDeploymentScript quitSession
]
