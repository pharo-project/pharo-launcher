accessing
templates
	| aDictionary templates |
	templates := OrderedCollection new.
	aDictionary := self dictionary.
	aDictionary valuesDo: [ :value | 
		(self baseDirectory / (value at: #name), 'zip') exists 
			ifTrue: [ templates add:
			(PhLLocalTemplate 
				name: (value at: #name)
				zipFile: self baseDirectory / (value at: #name), 'zip')  ]
			ifFalse: [ self flag:'TODO remove non existing stuff' ].
		].
	^ templates