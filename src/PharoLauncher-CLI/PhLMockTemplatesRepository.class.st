Class {
	#name : #PhLMockTemplatesRepository,
	#superclass : #Object,
	#instVars : [
		'localTemplateNames'
	],
	#category : #'PharoLauncher-CLI'
}

{ #category : #accessing }
PhLMockTemplatesRepository >> localTemplateNames [
   ^localTemplateNames
]

{ #category : #accessing }
PhLMockTemplatesRepository >> localTemplateNames: anObject [
   localTemplateNames := anObject.
]
