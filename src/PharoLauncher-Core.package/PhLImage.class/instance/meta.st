accessing
meta
	^ meta ifNil: [  meta := self metaFromDirectory: file parent ]