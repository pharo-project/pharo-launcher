accessing
originTemplateName

	^ self originTemplate ifNotNil: [ :t | t name ] ifNil: [ '' ]