Class {
	#name : 'PhLUnknownSettingType',
	#superclass : 'Error',
	#category : 'PharoLauncher-Settings',
	#package : 'PharoLauncher-Settings'
}

{ #category : 'signalling' }
PhLUnknownSettingType class >> signalType: aSymbol [

	^ self new
		messageText: aSymbol, ' is not part of valid types: ', (', ' join: PhLSetting validTypes)
]
