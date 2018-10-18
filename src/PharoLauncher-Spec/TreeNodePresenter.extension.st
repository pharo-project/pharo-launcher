Extension { #name : #TreeNodePresenter }

{ #category : #'*PharoLauncher-Spec' }
TreeNodePresenter >> nodePath [
	^self nodePathWith: (OrderedCollection new)
]

{ #category : #'*PharoLauncher-Spec' }
TreeNodePresenter >> nodePathWith: anOrderedCollection [
	
	self parentNode isNil 
		ifFalse: [ 
			self parentNode nodePathWith: anOrderedCollection  ].
		
	^anOrderedCollection 
			add: self;
			yourself
]
