Extension { #name : #Path }

{ #category : #'*PharoLauncher-Pharo9ToRemove-FileLocator' }
Path >> asFileLocatorOrReference [

	^ FileLocator fromPath: self ifNone: [ self asFileReference ]
]
