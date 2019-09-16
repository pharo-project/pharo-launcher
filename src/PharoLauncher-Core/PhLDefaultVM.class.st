Class {
	#name : #PhLDefaultVM,
	#superclass : #Object,
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #comparing }
PhLDefaultVM >> = aVM [

	^ aVM isDefaultVM
]

{ #category : #comparing }
PhLDefaultVM >> isDefaultVM [

	^ true
]

{ #category : #accessing }
PhLDefaultVM >> name [
	
	^ 'Default'
]
