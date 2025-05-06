"
I'm a launch configuration generated automatically when no Launch Configuration has been defined for an image.

When a value is changed, I'm converted to a classic PhLLaunchConfiguration.
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

{ #category : 'converting' }
PhLDefaultLaunchConfiguration >> asLaunchConfiguration [

	^ (PhLLaunchConfiguration withImage: self image)
			name: self name;
			yourself
]

{ #category : 'accessing' }
PhLDefaultLaunchConfiguration >> imageArguments: aCollection [ 
	
	^ self asLaunchConfiguration
			imageArguments: aCollection;
			yourself
]

{ #category : 'testing' }
PhLDefaultLaunchConfiguration >> isDefault [

	^ true
]

{ #category : 'accessing' }
PhLDefaultLaunchConfiguration >> name: aString [
	
	^ self asLaunchConfiguration
			name: aString;
			yourself
]

{ #category : 'accessing' }
PhLDefaultLaunchConfiguration >> vm: aPhLVirtualMachine [ 

	^ self asLaunchConfiguration
			vm: aPhLVirtualMachine;
			yourself
]

{ #category : 'accessing' }
PhLDefaultLaunchConfiguration >> vmArguments: aCollection [ 
	
	^ self asLaunchConfiguration
			vmArguments: aCollection;
			yourself
]

{ #category : 'accessing' }
PhLDefaultLaunchConfiguration >> workingDirectory: aFileReference [ 
	
	^ self asLaunchConfiguration
			workingDirectory: aFileReference;
			yourself
]
