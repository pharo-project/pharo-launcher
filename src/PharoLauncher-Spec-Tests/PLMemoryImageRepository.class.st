Class {
	#name : #PLMemoryImageRepository,
	#superclass : #Object,
	#instVars : [
		'images'
	],
	#category : #'PharoLauncher-Spec-Tests'
}

{ #category : #accessing }
PLMemoryImageRepository >> addImage: aPhLMockImage [ 
	
	images add: aPhLMockImage
]

{ #category : #accessing }
PLMemoryImageRepository >> images [
	^ images
]

{ #category : #accessing }
PLMemoryImageRepository >> initialize [

	super initialize.
	images := OrderedCollection new
]
