items creation
fetchOnlineImage: anURL 

	| list |
	list := OrderedCollection new.
	(FileList new directory: self url) fileList do: [ :each | 
			list add: (PharoLauncherElement
				name: (each path asZnUrl lastPathSegment) 
				url: (each path asZnUrl pathPrintString )
				category: 'Existing')
		].
	^list