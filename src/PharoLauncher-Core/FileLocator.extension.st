Extension { #name : #FileLocator }

{ #category : #'*PharoLauncher-Core' }
FileLocator class >> launcherUserFilesLocation [
	^ self origin: #launcherUserFilesLocation
]

{ #category : #'*PharoLauncher-Core' }
FileLocator class >> supportedOrigins [
	| origins current |
	origins := IdentitySet new.
	current := Resolver.
	[current notNil] whileTrue:
		[origins addAll: current supportedOrigins.
		current := current next].
	^ origins
		remove: #vmDirectory ifAbsent: [  ];
		remove: #vmBinary ifAbsent: [  ];
		remove: #localDirectory ifAbsent: [  ];
		remove: #imageDirectory ifAbsent: [  ];
		yourself
]
