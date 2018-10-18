Extension { #name : #UnixPlatform }

{ #category : #'*PharoLauncher-Core' }
UnixPlatform >> privOpenFileBrowserOn: pathString [
	^ PhLProcessWrapper command: ('xdg-open "{1}"' format: {pathString})
]
