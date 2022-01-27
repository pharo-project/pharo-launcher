Extension { #name : #String }

{ #category : #'*PharoLauncher-100Compatibility' }
String >> asFileLocatorOrReference [

	^ FileLocator fromString: self ifNone: [ self asFileReference ]
]
