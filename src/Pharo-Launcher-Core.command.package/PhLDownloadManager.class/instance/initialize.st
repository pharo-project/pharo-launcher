initialize-release
initialize
	super initialize.
	semaphore := Semaphore forMutualExclusion.
	errors := OrderedCollection new asValueHolder.
	self reset