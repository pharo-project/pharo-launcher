Extension { #name : #MacOSPlatform }

{ #category : #'*PharoLauncher-Core' }
MacOSPlatform >> privOpenFileBrowserOn: pathString [
	^ PhLProcessWrapper command: ('open "{1}"' format: {pathString})
]
