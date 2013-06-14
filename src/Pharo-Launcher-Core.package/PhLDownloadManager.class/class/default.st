accessing
default
	^ Default ifNil: [ self setDefault: self new ]