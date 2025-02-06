Extension { #name : 'FileReference' }

{ #category : '*PharoLauncher-Tests-Functional' }
FileReference >> delete [
	"Deletes the referenced file or directory. If the directory is not empty,
	raises an error. Use #deleteAll to delete with the children."

	(self isDirectory and:
	[ self isSymlink not and: 
	[ self hasChildren ] ])
		ifTrue:[
			Smalltalk logStdErrorDuring: [ :stderr | 
				stderr nextPutAll: 'children:'; cr.
				self children do: [ :child | stderr nextPutAll: '  - '; nextPutAll: child asString; cr ]
				 ].
			DirectoryIsNotEmpty signalWith: self ].
	filesystem delete: path
]
