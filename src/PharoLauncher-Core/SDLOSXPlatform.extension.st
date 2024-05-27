Extension { #name : 'SDLOSXPlatform' }

{ #category : '*PharoLauncher-Core' }
SDLOSXPlatform >> initPlatformSpecific [	
	ObjCLibrary uniqueInstance
		sendMessageNamed: 'finishLaunching'
		to: ObjCLibrary uniqueInstance sharedApplication.
	
	MacOsPharoLauncherMenu uniqueInstance installInOSXWindow.

]
