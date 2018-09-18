instance creation
on: aDomainObject
	| decorator |
	decorator := self basicNewWithOwner: nil.
	decorator decoree
		setModelBeforeInitialization: aDomainObject;
		initialize.	
	^ decorator