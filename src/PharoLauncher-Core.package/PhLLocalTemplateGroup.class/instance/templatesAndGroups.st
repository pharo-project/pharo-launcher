accessing
templatesAndGroups
	"Read the cache file to answer a list of already downloaded templates"
	| aDictionary templates |
	templates := SortedCollection sortBlock: [ :e1 :e2 | e1 name < e2 name ].
	aDictionary := self dictionary.
	aDictionary valuesDo: [ :value | 
		(self baseDirectory / (value at: #name), 'zip') exists 
			ifTrue: [ templates add:
			(PhLLocalTemplate 
				name: (value at: #name)
				zipFile: self baseDirectory / (value at: #name), 'zip')  ]
			ifFalse: [ self flag:'TODO remove non existing stuff' ].
		].
	PhLLaunchImageCommand new pharoStableImagePath ifNotNil: [:image | 
		templates add: 
			(PhLLocalTemplate 
				name: 'Pharo image (stable)'
				zipFile: image)
		].
	^ templates