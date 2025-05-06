"
I'm a launch configuration generated automatically when no Launch Configuration has been defined for an image.
"
Class {
	#name : 'PhLDefaultLaunchConfiguration',
	#superclass : 'PhLLaunchConfiguration',
	#category : 'PharoLauncher-Core-Model',
	#package : 'PharoLauncher-Core',
	#tag : 'Model'
}

{ #category : 'instance creation' }
PhLDefaultLaunchConfiguration class >> defaultName [
	^ 'Default'
]

{ #category : 'instance creation' }
PhLDefaultLaunchConfiguration class >> withImage: anImage [

	^ (super withImage: anImage)
		name: self defaultName;
		yourself
]

{ #category : 'testing' }
PhLDefaultLaunchConfiguration >> isDefault [

	^ true
]
