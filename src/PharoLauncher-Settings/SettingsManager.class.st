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
		'settings'
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
SettingsManager >> settings [

	^ settings
]

{ #category : 'accessing' }
SettingsManager >> settings: aListOfSettings [

	settings := aListOfSettings
]

{ #category : 'storing' }
SettingsManager >> storeExactStoredSettings: aCollectionOfStoredSettings on: aStream [

	self defaultStoredSettingsWriter
		stream: aStream;
		addSettings: aCollectionOfStoredSettings;
		store
]

{ #category : 'storing' }
SettingsManager >> storeSetting: aSetting [
	
	self storeSettings: (Array with: aSetting)
]

{ #category : 'storing' }
SettingsManager >> storeSettings [
	
	self flag: 'TO DO'
	"self storeSettings: self settings"
]

{ #category : 'storing' }
SettingsManager >> storeSettings: aListOfSettings [
	
	self storeStoredSettings: (self storedSettingsFor: aListOfSettings)
]

{ #category : 'storing' }
SettingsManager >> storeStoredSettings: aCollectionOfStoredSettings [
	"It stores a collection of stored settings on the disk."

	self writeStreamDo: [ :stream | self storeExactStoredSettings: aCollectionOfStoredSettings on: stream ]
]

{ #category : 'accessing' }
SettingsManager >> storedSettingFactory [

	^ StoredSettingsFactory new
]

{ #category : 'converting' }
SettingsManager >> storedSettingFor: aSetting [

	^ self storedSettingFactory from: aSetting
]

{ #category : 'converting' }
SettingsManager >> storedSettingsFor: aListOfSetting [

	^ self storedSettingFactory fromSettingNodes: aListOfSetting
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

{ #category : 'loading' }
SettingsManager >> updateSettingsWith: aListOfStoredSettings [

	aListOfStoredSettings do: [ :storedSetting |
			settings
				detect: [ :aSetting | storedSetting isForSettingNode: aSetting ]
				ifFound: [ :aSetting | storedSetting updateSettingNode: aSetting ]
				ifNone: [ "ignore it" ] ]
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
