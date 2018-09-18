actions
showPrivateVms: aBoolean
	elementsBlock := aBoolean
		ifTrue: [ privateVmsBlock ]
		ifFalse: [ vmBlock ].
	self refresh