"
Null pattern for a PhLLaunchConfiguration.
Used to display information when no launch configuration is selected.
"
Class {
	#name : #PhLNullLaunchConfiguration,
	#superclass : #Object,
	#category : #'PharoLauncher-Spec2'
}

{ #category : #accessing }
PhLNullLaunchConfiguration >> imageArguments [ 
	^ #()
]

{ #category : #testing }
PhLNullLaunchConfiguration >> isNullConfiguration [
	^ true
]

{ #category : #accessing }
PhLNullLaunchConfiguration >> name [
	^ ''
]

{ #category : #accessing }
PhLNullLaunchConfiguration >> vm [
	^ nil
]

{ #category : #accessing }
PhLNullLaunchConfiguration >> vmArguments [ 
	^ #()
]
