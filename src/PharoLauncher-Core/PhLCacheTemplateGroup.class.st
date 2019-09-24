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
	#category : 'PharoLauncher-Core-Model'
}

{ #category : #'instance creation' }
PhLCacheTemplateGroup class >> group: aTemplateGroup [
	^ self new
		setGroup: aTemplateGroup;
		yourself
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

{ #category : #'as yet unclassified' }
PhLCacheTemplateGroup >> refresh [
	templatesAndGroups := nil
]

{ #category : #'initialize-release' }
PhLCacheTemplateGroup >> setGroup: templateGroup [
	delegate := templateGroup.
]

{ #category : #accessing }
PhLCacheTemplateGroup >> templatesAndGroups [
	^ templatesAndGroups
		ifNil: [ 
			"#simplifiedTemplatesAndGroups will typically use the network and may fail. If the network is unreliable, it is better to save the error and not call #templateAndGroups a thousand times. Let the user interface decide when to try again (by calling #reset)."
			templatesAndGroups := [ delegate templatesAndGroups ]
				on: PhLError
				do: [ :err | Array with: err ] ]
]
