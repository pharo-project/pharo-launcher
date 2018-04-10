accessing
target
	^ target ifNil: [ target := self requestTargetLocation asFileReference ]