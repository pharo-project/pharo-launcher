"
I aggregate different template sources and provide a common API to access sources.
"
Class {
	#name : #PhLCompositeTemplateSources,
	#superclass : #PhLTemplateSources,
	#instVars : [
		'templateSources'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #'instance creation' }
PhLCompositeTemplateSources class >> fromFile [
	self shouldNotImplement
]

{ #category : #initialization }
PhLCompositeTemplateSources >> initializeWith: aListOfTemplateSources [
	templateSources := aListOfTemplateSources
]

{ #category : #accessing }
PhLCompositeTemplateSources >> sources [
	^ templateSources flatCollect: #sources
]
