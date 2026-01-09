"
I manage a set of settings. I can load them from disk, store them to disk.
"
Class {
	#name : 'SettingsManager',
	#superclass : 'Object',
	#instVars : [
		'storedSettingsReader',
		'readStream',
		'fileReference',
		'writeStream',
		'settings',
		'storedSettingsMerger',
		'storedSettingsWriter'
	],
	#category : 'PharoLauncher-Settings',
	#package : 'PharoLauncher-Settings'
}

{ #category : 'instance creation' }
SettingsManager class >> forSettings: aListOfSettings [

	^ self new
		settings: aListOfSettings;
		yourself 
]

{ #category : 'loading' }
SettingsManager >> allStoredSettings [
	"Load all stored settings from the read stream."
	
	^ self storedSettingsReader secureLoad
]

{ #category : 'accessing' }
SettingsManager >> defaultStoredSettingsMerger [

	^ StoredSettingsMerger new
]

{ #category : 'accessing' }
SettingsManager >> defaultStoredSettingsReader [

	^ SettingsStonReader new
]

{ #category : 'accessing' }
SettingsManager >> defaultStoredSettingsWriter [

	^ SettingsStonWriter new
]

{ #category : 'private - storing' }
SettingsManager >> ensureFileReferenceParent [
	"It ensures that the parent directory exists."

	self fileReference ifNotNil: [ :file |
		file parent ensureCreateDirectory ]
]

{ #category : 'accessing' }
SettingsManager >> fileReference [
	^ fileReference
]

{ #category : 'accessing' }
SettingsManager >> fileReference: aFileReference [ 
	
	fileReference := aFileReference 
]

{ #category : 'loading' }
SettingsManager >> loadSettings [
	
	self updateSettingsWith: self allStoredSettings
]

{ #category : 'private - storing' }
SettingsManager >> mergeStoredSettings: aCollectionOfStoredSettings [

	^ self storedSettingsMerger
		addStoredSettings: self allStoredSettings;
		addStoredSettings: aCollectionOfStoredSettings;
		storedSettings
]

{ #category : 'accessing' }
SettingsManager >> readStream [

	^ readStream ifNil: [
			  self fileReference ifExists: [ :file | file readStream ] ifAbsent: [ nil ] ]
]

{ #category : 'accessing' }
SettingsManager >> readStream: aReadStream [ 
	readStream := aReadStream
]

{ #category : 'private - storing' }
SettingsManager >> removeFileReferenceIfExists [
	"We have to remove the file before writing new settings."

	| newFileReference |
	fileReference ifNil: [ ^ self ].
	fileReference ifAbsent: [ ^ self ].
	
	newFileReference := fileReference withExtension: 'old.txt'.
	newFileReference ensureDelete.
	fileReference copy renameTo: newFileReference basename
]

{ #category : 'accessing' }
SettingsManager >> settingNamed: identifier [

	^ settings detect: [ :setting | setting settingIdentifier = identifier ]
]

{ #category : 'accessing' }
SettingsManager >> settings [

	^ settings
]

{ #category : 'accessing' }
SettingsManager >> settings: aListOfSettings [

	settings := aListOfSettings
]

{ #category : 'accessing' }
SettingsManager >> settingsFromIdentifiers: identifiers [

	^ identifiers
		  collect: [ :identifier |
				  self settings detect: [ :setting |
					  setting settingIdentifier = identifier ] ]
		  thenReject: [ :each | each isNil ]
]

{ #category : 'storing' }
SettingsManager >> storeExactStoredSettings: allStoredSettings [

	self
		ensureFileReferenceParent;
		removeFileReferenceIfExists.
		
	self fileReference writeStreamDo: [ :stream |
		self storeExactStoredSettings: allStoredSettings on: stream ]
]

{ #category : 'private - storing' }
SettingsManager >> storeExactStoredSettings: aCollectionOfStoredSettings on: aStream [

	self storedSettingsWriter
		stream: aStream;
		addSettings: aCollectionOfStoredSettings;
		store
]

{ #category : 'storing' }
SettingsManager >> storeIdentifier: aSettingIdentifier [
	
	self storeIdentifiers: (Array with: aSettingIdentifier)
]

{ #category : 'storing' }
SettingsManager >> storeIdentifiers: aListOfSettingIdentifiers [
	
	settings := self settingsFromIdentifiers: aListOfSettingIdentifiers.
	self storeSettings: settings 
]

{ #category : 'storing' }
SettingsManager >> storeSetting: aSetting [
	
	self storeSettings: (Array with: aSetting)
]

{ #category : 'storing' }
SettingsManager >> storeSettings [
	
	self storeSettings: self settings
]

{ #category : 'storing' }
SettingsManager >> storeSettings: aListOfSettings [
	
	self storeStoredSettings: (self storedSettingsFor: aListOfSettings)
]

{ #category : 'storing' }
SettingsManager >> storeStoredSettings: aCollectionOfStoredSettings [
	"It stores a collection of stored settings on the disk."

	| allStoredSettings |
	allStoredSettings := self mergeStoredSettings: aCollectionOfStoredSettings.
	self storeExactStoredSettings: allStoredSettings
]

{ #category : 'accessing' }
SettingsManager >> storedSettingFactory [

	^ StoredSettingsFactory new
]

{ #category : 'loading' }
SettingsManager >> storedSettingFor: aSettingIdentifier [

	^ self allStoredSettings
				detect: [ :eachStoredSetting |
					eachStoredSetting isForSettingIdentifier: aSettingIdentifier ]
]

{ #category : 'converting' }
SettingsManager >> storedSettingsFor: aListOfSetting [

	^ self storedSettingFactory fromSettingNodes: aListOfSetting
]

{ #category : 'accessing' }
SettingsManager >> storedSettingsMerger [

	^ storedSettingsMerger ifNil: [ self defaultStoredSettingsMerger ]
]

{ #category : 'accessing' }
SettingsManager >> storedSettingsReader [

	^ (storedSettingsReader ifNil: [ self defaultStoredSettingsReader ])
		stream: self readStream;
		yourself
]

{ #category : 'accessing' }
SettingsManager >> storedSettingsReader: aStoredSettingReader [

	storedSettingsReader := aStoredSettingReader
]

{ #category : 'accessing' }
SettingsManager >> storedSettingsWriter [

	^ storedSettingsWriter ifNil: [ self defaultStoredSettingsWriter ]
]

{ #category : 'loading' }
SettingsManager >> updateSettings: someSettings [

	self updateSettings: someSettings with: self allStoredSettings
]

{ #category : 'private - loading' }
SettingsManager >> updateSettings: aLitOfSettings with: aListOfStoredSettings [

	aListOfStoredSettings do: [ :storedSetting |
			aLitOfSettings
				detect: [ :aSetting | storedSetting isForSettingIdentifier: aSetting settingIdentifier ]
				ifFound: [ :aSetting | storedSetting updateSettingNode: aSetting ]
				ifNone: [ "ignore it" ] ]
]

{ #category : 'private - loading' }
SettingsManager >> updateSettingsWith: aListOfStoredSettings [

	self updateSettings: settings with: aListOfStoredSettings
]

{ #category : 'private - storing' }
SettingsManager >> writeStream [

	^ writeStream ifNil: [
			  self ensureFileReferenceParent.
			  self removeFileReferenceIfExists.
			  self fileReference writeStream ]
]

{ #category : 'private - storing' }
SettingsManager >> writeStreamDo: aBlock [
	| stream |
	stream := self writeStream.
	^ [ aBlock value: stream ]
		ensure: [ stream close ]
]
