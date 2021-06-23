"
Take care of caching for all subclasses of PhLAbstractTemplateGroup. 

Instance Variables
	delegate:		a PhLAbstractTemplateGroup
	simplifiedTemplateAndGroups:			a cached version of what my delegate answered to #simplifiedTemplateAndGroups.
"
Class {
	#name : #PhLCacheTemplateGroup,
	#superclass : #PhLAbstractTemplateGroup,
	#instVars : [
		'delegate',
		'templatesAndGroups'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #'instance creation' }
PhLCacheTemplateGroup class >> group: aTemplateGroup [
	^ self new
		setGroup: aTemplateGroup;
		yourself
]

{ #category : #'as yet unclassified' }
PhLCacheTemplateGroup >> cliPrintString [
	^ self asString 
]

{ #category : #comparing }
PhLCacheTemplateGroup >> hash [
	^ delegate hash
]

{ #category : #accessing }
PhLCacheTemplateGroup >> icon [
	^ delegate icon
]

{ #category : #testing }
PhLCacheTemplateGroup >> isHighlighted [
	^ delegate isHighlighted
]

{ #category : #accessing }
PhLCacheTemplateGroup >> name [
	^ delegate name
]

{ #category : #actions }
PhLCacheTemplateGroup >> refresh [
	templatesAndGroups := nil
]

{ #category : #initialization }
PhLCacheTemplateGroup >> setGroup: templateGroup [
	delegate := templateGroup.
]

{ #category : #accessing }
PhLCacheTemplateGroup >> templatesAndGroups [
	^ templatesAndGroups
		ifNil: [ templatesAndGroups := delegate templatesAndGroups ]
		
]
