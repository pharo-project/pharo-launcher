Class {
	#name : #PhLImageBisectCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLImageBisectCliCommandTest >> testGetPharoDevVersionWhenNoVersionSpecified [

	context arguments: #( 'launcher' 'image' 'bisect' ).

	self
		assert: context command pharoVersion
		equals: (SystemVersion current major + 1) asString , '0' 
	"Pharo Launcher is based on the latest Pharo stable but we should find a way to control template sources in a test context"
]
