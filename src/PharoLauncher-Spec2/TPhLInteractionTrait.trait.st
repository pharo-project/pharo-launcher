"
This behavior should be handled in Spec. Onde done, this trait could be removed.

This trait provides an abstraction to provide user interaction (confirm, inform, etc.)
"
Trait {
	#name : 'TPhLInteractionTrait',
	#category : 'PharoLauncher-Spec2',
	#package : 'PharoLauncher-Spec2'
}

{ #category : 'user interaction' }
TPhLInteractionTrait >> newConfirmation [

	^ PhLUIConfirmation new
		application: self application;
		yourself	
]

{ #category : 'user interaction' }
TPhLInteractionTrait >> newFileRequest [

	^ PhLUIFileRequest new
		application: self application;
		yourself	
]

{ #category : 'user interaction' }
TPhLInteractionTrait >> newInformation [

	^ PhLUIInformation new
		application: self application;
		yourself	
]

{ #category : 'user interaction' }
TPhLInteractionTrait >> newRequest [

	^ PhLUIRequest new
		application: self application;
		yourself
]
