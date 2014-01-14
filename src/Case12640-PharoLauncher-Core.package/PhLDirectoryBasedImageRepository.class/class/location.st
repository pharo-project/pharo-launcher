accessing
location
	^ Location ifNil: [ Location := self defaultLocation ]