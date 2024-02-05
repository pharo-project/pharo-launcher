Extension { #name : #OmSessionStore }

{ #category : #'*PharoLauncher-Core' }
OmSessionStore class >> startUp [
	
	PharoLauncherApplication isDeployed ifTrue: [ ^ self ].
	 
	registry do: [ :each | each store ]
]
