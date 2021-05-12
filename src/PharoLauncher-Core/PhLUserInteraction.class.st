Class {
	#name : #PhLUserInteraction,
	#superclass : #Object,
	#category : #'PharoLauncher-Core-Commands'
}

{ #category : #accessing }
PhLUserInteraction >> application [

	^ PharoLauncherApplication default
]
