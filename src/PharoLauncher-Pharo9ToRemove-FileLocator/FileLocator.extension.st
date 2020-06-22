Extension { #name : #FileLocator }

{ #category : #'*PharoLauncher-Pharo9ToRemove-FileLocator' }
FileLocator >> asFileLocatorOrReference [
	^ self
]

{ #category : #'*PharoLauncher-Pharo9ToRemove-FileLocator' }
FileLocator class >> fromPath: aPath ifNone: notFoundBlock [
	"Returns a file locator if aPath is a reference to a supported origin or is a child of an origin.
	If no locator matches, return the result of the evaluation of notFoundBlock.
	Should not be called direcly. Prefer the use of Path or String>>#asFileLocatorOrReference "

	| locators locatorsPaths |
	locators := self supportedOrigins
		collect: [ :origin | self origin: origin ]
		as: OrderedCollection.
	locatorsPaths := (locators collect: [ :e | e -> e asPath ]) asDictionary.
	(locators sort:
			[ :a :b | (locatorsPaths at: b) <= (locatorsPaths at: a) ])
		do: [ :locator | 
			((locatorsPaths at: locator) = aPath or: [ (locatorsPaths at: locator) containsPath: aPath ])
				ifTrue: [ ^ locator resolve: (aPath relativeToPath: (locatorsPaths at: locator)) ] ].
	^ notFoundBlock value
]

{ #category : #'*PharoLauncher-Pharo9ToRemove-FileLocator' }
FileLocator class >> fromString: aString ifNone: notFoundBlock [
	"Returns a file locator if aString converted as path is a reference to a supported origin or is a child of an origin.
	If no locator matches, return the result of the evaluation of notFoundBlock.
	Should not be called direcly. Prefer the use of Path or String>>#asFileLocatorOrReference "
	
	^ self fromPath: aString asPath ifNone: notFoundBlock
]
