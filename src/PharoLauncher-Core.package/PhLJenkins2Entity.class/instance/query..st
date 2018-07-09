protected
query: jenkinsType
	| query |
	query := jenkinsType jsonName , '[' , jenkinsType jsonFieldsQuery , ']'.
	^ ((self jsonQuery: query) at: jenkinsType jsonName ifAbsent: [nil])
		ifNil: [ #() ]
		ifNotNil: [ :jsonObjects | 
			jsonObjects
				collect: [ :json | 
					(jenkinsType newWithProperties: json)
						parent: self;
						yourself ] ]