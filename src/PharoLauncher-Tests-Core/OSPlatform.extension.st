Extension { #name : #OSPlatform }

{ #category : #'*PharoLauncher-Tests-Core' }
OSPlatform class >> usePlatform: anOSPlatform during: aBlock [

	| osPlatform |
	osPlatform := self current.
	[ Current := anOSPlatform.
	 aBlock value ]
	ensure: [ Current := osPlatform ].
]
