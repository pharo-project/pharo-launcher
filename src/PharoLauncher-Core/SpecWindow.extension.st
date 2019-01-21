Extension { #name : #SpecWindow }

{ #category : #'*PharoLauncher-Core' }
SpecWindow >> close [

	self model 
		ifNotNil: [ 
			self model askOkToClose
				ifTrue: [ self okToChange ifFalse: [ ^ self ] ] ].
		
	super close
]
