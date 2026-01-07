"
I represent a setting for which the domain value is an interval.
"
Class {
	#name : 'PhLRangeSetting',
	#superclass : 'PhLSetting',
	#instVars : [
		'range'
	],
	#category : 'PharoLauncher-Settings',
	#package : 'PharoLauncher-Settings'
}

{ #category : 'accessing' }
PhLRangeSetting >> range [
	^ range
]

{ #category : 'accessing' }
PhLRangeSetting >> range: anInterval [ 
	range := anInterval
]
