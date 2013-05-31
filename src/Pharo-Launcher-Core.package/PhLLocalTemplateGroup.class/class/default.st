accessing
default
	"We use a singleton because I can foresee only 1 instance for this class."
	^ Default	ifNil: [ Default := self new ]