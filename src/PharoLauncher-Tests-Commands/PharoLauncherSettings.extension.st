Extension { #name : 'PharoLauncherSettings' }

{ #category : '*PharoLauncher-Tests-Commands' }
PharoLauncherSettings class >> default: anObject during: aBlock [

	| oldDefault |
	oldDefault := Default.
	[ Default := anObject.
	  aBlock value ] ensure: [ Default := oldDefault ]
]
