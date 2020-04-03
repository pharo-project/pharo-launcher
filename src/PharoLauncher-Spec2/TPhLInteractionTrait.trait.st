"
This behavior should be handled in Spec. Onde done, this trait could be removed.

This trait provides an abstraction to provide user interaction (confirm, inform, etc.)
"
Trait {
	#name : #TPhLInteractionTrait,
	#category : #'PharoLauncher-Spec2'
}

{ #category : #'user interaction' }
TPhLInteractionTrait >> newConfirmation [
	^ PhLUIConfirmation new
]

{ #category : #'user interaction' }
TPhLInteractionTrait >> newFileRequest [
	^ PhLUIFileRequest new
]

{ #category : #'user interaction' }
TPhLInteractionTrait >> newInformation [
	^ PhLUIInformation new
]

{ #category : #'user interaction' }
TPhLInteractionTrait >> newRequest [
	^ PhLUIRequest new
]
