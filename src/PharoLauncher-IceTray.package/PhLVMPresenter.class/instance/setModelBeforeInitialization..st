initialization
setModelBeforeInitialization: aDomainObject
	vmBlock := aDomainObject first.
	privateVmsBlock := (aDomainObject size = 1)
		ifTrue: [ [ #() ] ]
		ifFalse: [ aDomainObject second ].
	elementsBlock := vmBlock.