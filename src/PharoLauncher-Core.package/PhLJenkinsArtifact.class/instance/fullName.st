accessing
fullName
	^ String
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
						<< value ] ]