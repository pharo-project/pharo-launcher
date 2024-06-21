"
Null pattern for a PhLImage.
Used to display information when no image is selected.
"
Class {
	#name : 'PhLNullImage',
	#superclass : 'Object',
	#category : 'PharoLauncher-Spec2-Model',
	#package : 'PharoLauncher-Spec2',
	#tag : 'Model'
}

{ #category : 'accessing' }
PhLNullImage >> architecture [
	
	^ ''
]

{ #category : 'accessing' }
PhLNullImage >> defaultArguments [
	
	^ #()
]

{ #category : 'accessing' }
PhLNullImage >> description [
	
	^ '<no description given>'
]

{ #category : 'accessing' }
PhLNullImage >> initializationScript [
	^ nil
]

{ #category : 'accessing' }
PhLNullImage >> initializationScript: aFileReference [

]

{ #category : 'accessing' }
PhLNullImage >> lastModification [
	
	^ nil
]

{ #category : 'accessing' }
PhLNullImage >> lastUsedConfiguration: aLaunchConfiguration [

]

{ #category : 'accessing' }
PhLNullImage >> launchConfigurations [
	
	^ #()
]

{ #category : 'accessing' }
PhLNullImage >> location [

	^ ''
]

{ #category : 'accessing' }
PhLNullImage >> name [
	^ 'No image selected'
]

{ #category : 'accessing' }
PhLNullImage >> originTemplateName [
	
	^ ''
]

{ #category : 'accessing' }
PhLNullImage >> originTemplateUrl [
	
	^ ''
]

{ #category : 'accessing' }
PhLNullImage >> shouldRunInitializationScript [
	^ false
]
