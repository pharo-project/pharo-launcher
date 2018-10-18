Extension { #name : #ComposablePresenter }

{ #category : #'*PharoLauncher-Spec' }
ComposablePresenter >> topWindowHolder [
     ^ owner
            ifNil: [ window ]
            ifNotNil: [ :o | o topWindowHolder ].
]

{ #category : #'*PharoLauncher-Spec' }
ComposablePresenter >> whenWindowClosed: aBlock [
	"Sometimes the owner window has been set before sub-components call this method, "
	"so the event never occurs to trigger evaluation of #whenChangedDo: block, "
	"in which case evaluate it here"
	
	self topWindowHolder value
		ifNil: [  self topWindowHolder whenChangedDo: [  :w  | w whenClosedDo: aBlock ] ]
		ifNotNil: [ :w | w whenClosedDo: aBlock ]

]
