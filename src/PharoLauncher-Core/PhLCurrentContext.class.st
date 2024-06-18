Class {
	#name : 'PhLCurrentContext',
	#superclass : 'Notification',
	#category : 'PharoLauncher-Core-Commands',
	#package : 'PharoLauncher-Core',
	#tag : 'Commands'
}

{ #category : 'evaluating' }
PhLCurrentContext class >> defaultValue [

	^ PharoLauncherApplication default new: SpPresenter
]

{ #category : 'as yet unclassified' }
PhLCurrentContext class >> use: anObject during: aBlock [
	"Set the dynamic value of the receiver to anObject during the evaluation of aBlock."
	
	^ aBlock 
		on: self 
		do: [ :aNotification | aNotification resume: anObject ]
]

{ #category : 'evaluating' }
PhLCurrentContext class >> value [
	"Answer the dynamic value of the receiver."
	
	^ self signal
]

{ #category : 'handling' }
PhLCurrentContext >> defaultAction [

	^ self class defaultValue
]
