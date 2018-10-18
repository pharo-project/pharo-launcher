"
I'm exactly the same as the standard settings browser except I save to a dedicated pharo launcher setting file.
"
Class {
	#name : #PhLSettingTree,
	#superclass : #SettingTree,
	#category : 'PharoLauncher-Core-Settings'
}

{ #category : #accessing }
PhLSettingTree >> persistence [
	^ persistence ifNil: 
		[ persistence := SystemSettingsPersistence new 
			fileReference: PhLSettingBrowser preferencesFile;
			settingTree: self;
			yourself ]
]
