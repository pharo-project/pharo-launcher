Extension { #name : 'PharoLauncherSettings' }

{ #category : '*PharoLauncher-Settings-Tests' }
PharoLauncherSettings >> manager [

	^ manager
]

{ #category : '*PharoLauncher-Settings-Tests' }
PharoLauncherSettings >> names [

	^ manager settings collect: [ :setting | setting name ]
]
