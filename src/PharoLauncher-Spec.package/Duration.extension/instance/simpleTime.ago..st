*PharoLauncher-Spec
simpleTime: aString ago: aCount
	^ aCount asFloat floor asString , ' ' , (aString asPluralBasedOn: aCount) , ' ago'