Extension { #name : #MacOSPlatform }

{ #category : #'*pharoLauncher-Core-Commands' }
MacOSPlatform >> privOpenFileBrowserOn: pathString [
	^ PhLProcessWrapper command: ('open "{1}"' format: {pathString})
]
