"
I build the settings (basic settings and groups) from a list of pragmas.
These pragma identify methods with settings description that I can execute, passing myself as argument, to build the settings.

You can use me as follows:
```
builder := SettingsBuilder forPragmaNamed: #settings_test_data.
builder settings
```

When accessing settings, if not available, settings will be build.
"
Class {
	#name : 'SettingsBuilder',
	#superclass : 'Object',
	#instVars : [
		'pragmas',
		'settings',
		'parents',
		'currentPragma'
	],
	#category : 'PharoLauncher-Settings',
	#package : 'PharoLauncher-Settings'
}

{ #category : 'instance creation' }
SettingsBuilder class >> forPragmaNamed: aSymbol [
	
	| collector |
	collector := PragmaCollector
		selectors: (Array with: aSymbol)
		filter: [ :pragma | pragma methodClass isClassSide ].
		
	^ self forPragmas: collector pragmas
]

{ #category : 'instance creation' }
SettingsBuilder class >> forPragmas: aListOfPaagmas [
	
	^ self new
		pragmas: aListOfPaagmas;
		yourself
]

{ #category : 'private - building' }
SettingsBuilder >> addSettingNamed: aSymbol class: aClass [

	| setting |
	setting := aClass new
		           name: aSymbol;
		           yourself.
	self setParentIfAnyTo: setting.
	setting declaration: currentPragma.
	settings add: setting.
	^ setting
]

{ #category : 'private - building' }
SettingsBuilder >> buildPragma: aPragma [

	currentPragma := aPragma.
	ActiveSettingBuilder value: self during: [
			aPragma methodClass instanceSide
				perform: aPragma methodSelector
				with: self ].
	currentPragma := nil
]

{ #category : 'private - building' }
SettingsBuilder >> buildSettings [
	
	pragmas do: [ :pragma | self buildPragma: pragma ]
]

{ #category : 'building' }
SettingsBuilder >> button: aString [

	^ self addSettingNamed: aString asSymbol class: PhLActionSetting
]

{ #category : 'building' }
SettingsBuilder >> group: aString [

	^ self addSettingNamed: aString asSymbol class: PhLSettingsGroup
]

{ #category : 'initialization' }
SettingsBuilder >> initialize [ 
	
	super initialize.
	settings := OrderedCollection new.
	parents := Stack new
]

{ #category : 'private - building' }
SettingsBuilder >> parent: aSetting while: aBlock [

	parents push: aSetting.
	[ aBlock value ] ensure: [ parents pop ]
]

{ #category : 'building' }
SettingsBuilder >> pickOne: aString [

	^ self addSettingNamed: aString asSymbol class: PhLPickOneSetting
]

{ #category : 'initialization' }
SettingsBuilder >> pragmas: aListOfPragmas [ 
	
	pragmas := aListOfPragmas
]

{ #category : 'building' }
SettingsBuilder >> range: aString [

	^ self addSettingNamed: aString asSymbol class: PhLRangeSetting
]

{ #category : 'private - building' }
SettingsBuilder >> setParentIfAnyTo: aSetting [

	parents ifNotEmpty: [
			aSetting
				group: parents top;
				groupName: parents top name ]
]

{ #category : 'building' }
SettingsBuilder >> setting: aString [

	^ self addSettingNamed: aString asSymbol class: PhLSetting
]

{ #category : 'accessing' }
SettingsBuilder >> settings [
	
	^ settings ifEmpty: [ self buildSettings. settings ]
]
