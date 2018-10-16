instance creation
directory: aFileReference private: isPrivateVm
	| targetClass |
	targetClass := isPrivateVm ifTrue: [ PhLPrivateVirtualMachine ] ifFalse: [ self ].
	^ targetClass new 
		initializeOn: aFileReference;
		yourself 