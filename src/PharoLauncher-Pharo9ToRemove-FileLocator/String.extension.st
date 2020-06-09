Extension { #name : #String }

{ #category : #'*PharoLauncher-Pharo9ToRemove-FileLocator' }
String >> asFileLocatorOrReference [

	^ FileLocator fromString: self ifNone: [ self asFileReference ]
]
