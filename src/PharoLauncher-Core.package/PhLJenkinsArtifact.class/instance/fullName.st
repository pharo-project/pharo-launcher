accessing
fullName
	^ self options isEmpty
		ifTrue: [ self name ]
		ifFalse: [ String
		streamContents: [ :s | 
			s
				<< $(;
				<< self url lastPathSegment;
				<< $);
				space;
				<< self name.
			self options
				keysAndValuesDo: [ :key :value | 
					s space
						<< key;
						<< '=';
						<< value ] ] ]