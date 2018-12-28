Class {
	#name : #PhLCommandLine,
	#superclass : #Object,
	#traits : 'TClapBase',
	#classTraits : 'TClapBase classTrait',
	#category : #'PharoLauncher-CommandLine'
}

{ #category : #'command line' }
PhLCommandLine class >> buildCommand [
	^ (ClapCommand withName: 'new')
		description: 'Create a new image or template';
		add: ((ClapPositional withName: 'image')
			description: 'Name of the new image');
		add: ((ClapPositional withName: 'template')
			description: 'Name of the template to instanciate');
		meaning: [ :args |
			args context stdout << '(TODO: should make a new image)'; lf
		]
]

{ #category : #'command line' }
PhLCommandLine class >> launcher [
	<commandline>
	^ (ClapCommand withName: 'launcher')
			description: 'Manager for Pharo images';
			add: ClapCommand forHelp;
			add: self listCommand;
			add: self runCommand;
			add: self buildCommand;
			meaning: [ :args |
				args context stdout << 'Hello from the Pharo Launcher command-line tool (WIP)'; lf ]
]

{ #category : #'command line' }
PhLCommandLine class >> listCommand [
	^ (ClapCommand withName: 'list')
		description: 'List known images';
		add: ClapFlag forHelp;
		meaning: [ :args |
			args atName: 'help' ifFound: [ :help | help value; exitSuccess ].
			args validateAll.
			
			(self with: args) executeList ]
]

{ #category : #'command line' }
PhLCommandLine class >> runCommand [
	^ (ClapCommand withName: 'run')
		description: 'Launch specified image';
		add: ((ClapPositional withName: 'image')
			description: 'Name of the image to launch');
		meaning: [ :args |
			args atName: 'help' ifFound: [ :help | help value; exitSuccess ].
			args validateAll.
			
			(self with: args) executeRun ]
]

{ #category : #actions }
PhLCommandLine >> ambiguousQuery: images [
	self context stderr in: [ :stderr |
		stderr << 'Several images matched query:'; lf.
		self
			listImages: (self imagesMatching: self imageQuery)
			on: stderr ].

	self context exitFailure
]

{ #category : #'command line - entry point' }
PhLCommandLine >> executeList [
	self listImages: self images on: self context stdout
]

{ #category : #'command line - entry point' }
PhLCommandLine >> executeRun [
	self
		imagesMatching: self imageQuery
		ifExact: [ :img | self launchImage: img ]
		ifApproximate: [ :imgs |
			imgs size = 1
				ifTrue: [ self launchImage: imgs first ]
				ifFalse: [ self ambiguousQuery: imgs ] ]
		ifNone: [ self unmatchedQuery ]
]

{ #category : #accessing }
PhLCommandLine >> imageQuery [
	^ (arguments atName: 'image') value
]

{ #category : #'accessing - launcher' }
PhLCommandLine >> imageRepo [
	^ PhLDirectoryBasedImageRepository default
]

{ #category : #'accessing - launcher' }
PhLCommandLine >> images [
	^ self imageRepo images
]

{ #category : #'accessing - launcher' }
PhLCommandLine >> imagesMatching: query [
	| lowercaseQuery |
	lowercaseQuery := query asLowercase.

	^ self images select:
		[ :each | each name asLowercase beginsWith: query ]
]

{ #category : #'accessing - launcher' }
PhLCommandLine >> imagesMatching: query ifExact: exactBlock ifApproximate: approxBlock ifNone: noneBlock [
	| lowercaseQuery |
	lowercaseQuery := query asLowercase.

	^ (self images select: [ :each |
			each name asLowercase in: [ :name |
				name = lowercaseQuery ifTrue: [ ^ exactBlock cull: each ].
				name beginsWith: query ] ])
		ifEmpty: noneBlock
		ifNotEmpty: [ :approximateMatches | approxBlock cull: approximateMatches ]
]

{ #category : #actions }
PhLCommandLine >> launchImage: anImage [
	anImage launchWithSettings: false
]

{ #category : #actions }
PhLCommandLine >> listImages: images on: aStream [
	images do: [ :each | aStream << each name; lf ]
]

{ #category : #actions }
PhLCommandLine >> unmatchedQuery [
	self context stderr in: [ :stderr |
		stderr << 'No known image matched query! Available images:'; lf.
		self
			listImages: self images
			on: stderr ].
	
	self context exitFailure

]
