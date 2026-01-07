"
I represent a setting for which the value is a value from the list of domain values.
If domainValues is set, then the list of valid values is constant (initialized at declaration time). Instead, if getter is set, then the setting list is always dynamically computed.
"
Class {
	#name : 'PhLPickOneSetting',
	#superclass : 'PhLSetting',
	#instVars : [
		'domainValues'
	],
	#category : 'PharoLauncher-Settings',
	#package : 'PharoLauncher-Settings'
}

{ #category : 'accessing' }
PhLPickOneSetting >> domainValues [
	^ domainValues
]

{ #category : 'accessing' }
PhLPickOneSetting >> domainValues: aCollection [ 
	domainValues := aCollection
]
