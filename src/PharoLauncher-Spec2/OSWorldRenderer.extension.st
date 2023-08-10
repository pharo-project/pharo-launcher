Extension { #name : #OSWorldRenderer }

{ #category : #'*PharoLauncher-Spec2' }
OSWorldRenderer >> defaultWindowTitle [

	^ PharoLauncherApplication isDeployed 
		ifTrue: [ 'Pharo Launcher' ]
		ifFalse: [ Smalltalk image imageFile fullName ]
]

{ #category : #'*PharoLauncher-Spec2' }
OSWorldRenderer >> updateWindowTitle [

	"do nothing"
]
