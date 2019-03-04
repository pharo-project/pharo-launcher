Class {
	#name : #PhLMockImage,
	#superclass : #Object,
	#instVars : [
		'name',
		'architecture',
		'modified',
		'launched'
	],
	#category : #'PharoLauncher-Spec-Tests'
}

{ #category : #'instance creation' }
PhLMockImage class >> named: aName arch: anArch modified: aModified [
	
	^ self new
		name: aName;
		architecture: anArch;
		modified: aModified;
		yourself
]

{ #category : #accessing }
PhLMockImage >> arch [
	
	^ architecture
]

{ #category : #accessing }
PhLMockImage >> architecture: aString [ 
	
	architecture := aString
]

{ #category : #accessing }
PhLMockImage >> description [
	
	^ String loremIpsum: 100
]

{ #category : #accessing }
PhLMockImage >> initialize [

	super initialize.
	launched := false
]

{ #category : #accessing }
PhLMockImage >> isLaunched [ 

	^ launched
]

{ #category : #accessing }
PhLMockImage >> lastModification [
	
	^ modified
]

{ #category : #accessing }
PhLMockImage >> launch [

	launched := true
]

{ #category : #accessing }
PhLMockImage >> location [
	
	^ FileSystem workingDirectory
]

{ #category : #accessing }
PhLMockImage >> modified [
	^ modified
]

{ #category : #accessing }
PhLMockImage >> modified: aDateAndTime [ 
	
	modified:= aDateAndTime 

]

{ #category : #accessing }
PhLMockImage >> name [
	^ name
]

{ #category : #accessing }
PhLMockImage >> name: aString [ 
	
	name := aString
]

{ #category : #'as yet unclassified' }
PhLMockImage >> originTemplateName [
	
	^ 'I am a template!'
]
