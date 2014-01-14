accessing
fullName
	^ String streamContents: [ :s|
		s << self name.
		self options keysAndValuesDo: [ :key :value | 
			s space << key; << '='; << value ]]