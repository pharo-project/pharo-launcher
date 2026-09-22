"
This behavior should be handled in Spec. Onde done, this trait could be removed.

This trait provides an abstraction to provide user interaction (confirm, inform, etc.)
"
Trait {
	#name : 'TPhLInteractionTrait',
	#category : 'PharoLauncher-Spec2-Application',
	#package : 'PharoLauncher-Spec2',
	#tag : 'Application'
}

{ #category : 'user interaction' }
TPhLInteractionTrait >> newChoice [

	^ ITUIChoice new
		application: self application;
		parentWindow: self window;
		yourself
]

{ #category : 'user interaction' }
TPhLInteractionTrait >> newConfirmation [

	^ ITConfirmation new
		application: self application;
		parentWindow: self window;
		yourself
]

{ #category : 'user interaction' }
TPhLInteractionTrait >> newFileRequest [

	^ ITFileRequest new
		application: self application;
		parentWindow: self window;
		yourself
]

{ #category : 'user interaction' }
TPhLInteractionTrait >> newInformation [

	^ ITInformation new
		application: self application;
		parentWindow: self window;
		yourself
]

{ #category : 'user interaction' }
TPhLInteractionTrait >> newRequest [

	^ ITRequest new
		application: self application;
		parentWindow: self window;
		yourself
]
