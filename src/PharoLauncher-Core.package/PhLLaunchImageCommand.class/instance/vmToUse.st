as yet unclassified
vmToUse
	^ self needsSpurVm
		ifTrue: [ self class spurFullPath ifEmpty: [ Smalltalk vm fullPath asString ] ]
		ifFalse: [ self class vmFullPath ifEmpty: [ self vm40Path fullName ] ]