accessing
templates
	^ templates ifNil: [ templates := delegate templates ]