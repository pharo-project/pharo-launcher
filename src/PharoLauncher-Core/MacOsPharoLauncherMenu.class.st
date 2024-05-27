"
I build Pharo Launcher Mac Os menus.
To intall me, run:
```
self new installInOSXWindow
```

"
Class {
	#name : 'MacOsPharoLauncherMenu',
	#superclass : 'Object',
	#classVars : [
		'UniqueInstance'
	],
	#category : 'PharoLauncher-Core-OS-Integration',
	#package : 'PharoLauncher-Core',
	#tag : 'OS-Integration'
}

{ #category : 'instance creation' }
MacOsPharoLauncherMenu class >> uniqueInstance [

	^ UniqueInstance ifNil: [ UniqueInstance := self new ].
]

{ #category : 'adding' }
MacOsPharoLauncherMenu >> buildPharoLauncherMenu [

	| mainMenu |
	mainMenu := CocoaMenu new.
	mainMenu addSubmenu: 'Pharo Launcher' with: [ :menu |
		menu
			addItemWithTitle: 'About Pharo Launcher' action: [ self doAbout ];
			addSeparator;
			addItemWithTitle: 'Preferences' action: [ self doPreferences ] shortcut: ',';
			addSeparator;
			addServicesMenu;
			addItemWithTitle: 'Quit Pharo Launcher' action: [ self doQuit ] shortcut: 'q' ].
	mainMenu beMainMenu
]

{ #category : 'actions' }
MacOsPharoLauncherMenu >> doAbout [

	UIManager default defer: [ (PhLAboutCommand forContext: PharoLauncherApplication default mainPresenter) execute ]
]

{ #category : 'actions' }
MacOsPharoLauncherMenu >> doPreferences [

	UIManager default defer: [ PhLOpenSettingsCommand new execute ]
]

{ #category : 'actions' }
MacOsPharoLauncherMenu >> doQuit [

	UIManager default defer: [ PhLDeploymentScript quitSession ] 
]

{ #category : 'actions' }
MacOsPharoLauncherMenu >> installInOSXWindow [

	self buildPharoLauncherMenu 
]
