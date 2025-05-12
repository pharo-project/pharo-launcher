"
I am a launch configuration that knows how to launch an image.
I have all the required information to run one:
 - vm
 - arguments
 - use settings
An image stores many of my instances so the user can choose one to launch it.
"
Class {
	#name : 'PhLLaunchConfiguration',
	#superclass : 'PhLDefaultLaunchConfiguration',
	#category : 'PharoLauncher-Core-Model',
	#package : 'PharoLauncher-Core',
	#tag : 'Model'
}

{ #category : 'instance creation' }
PhLLaunchConfiguration class >> defaultName [
	^ 'new configuration ...'
]

{ #category : 'serialization' }
PhLLaunchConfiguration class >> stonAllInstVarNames [

	^ super stonAllInstVarNames reject: [ :varName | 
		  #( #usePharoSettings #workingDirectory ) includes: varName ]
]

{ #category : 'accessing' }
PhLLaunchConfiguration >> imageArguments: aCollection [ 
	imageArguments := aCollection
]

{ #category : 'testing' }
PhLLaunchConfiguration >> isDefault [

	^ false
]

{ #category : 'accessing' }
PhLLaunchConfiguration >> name: aString [ 
	name := aString
]

{ #category : 'accessing' }
PhLLaunchConfiguration >> vm: aPhLVirtualMachine [ 

	self setVm: aPhLVirtualMachine
]

{ #category : 'accessing' }
PhLLaunchConfiguration >> vmArguments: aCollection [ 
	vmArguments := aCollection
]

{ #category : 'accessing' }
PhLLaunchConfiguration >> workingDirectory: aFileReference [
	workingDirectory := aFileReference
]
