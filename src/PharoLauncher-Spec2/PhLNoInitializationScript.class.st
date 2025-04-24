"
ull pattern for a PhLImage initialization script.
Used to display this information when no initialization script is selected.
"
Class {
	#name : 'PhLNoInitializationScript',
	#superclass : 'Object',
	#category : 'PharoLauncher-Spec2-Model',
	#package : 'PharoLauncher-Spec2',
	#tag : 'Model'
}

{ #category : 'converting' }
PhLNoInitializationScript >> asFileReference [
	
	^ nil
]

{ #category : 'accessing' }
PhLNoInitializationScript >> basename [
	^ #'No initialization script'
]
