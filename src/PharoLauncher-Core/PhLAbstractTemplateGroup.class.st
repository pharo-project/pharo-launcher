"
I represent a group of templates.

The #templateAndGroups method is very important. Calling this method must answer a collection of my subgroups and of templates that I directly contain.

Most of my subclasses won't have to do any caching, even the network-intensive ones. This is because PhLCacheTemplateGroup does that for everyone.
"
Class {
	#name : #PhLAbstractTemplateGroup,
	#superclass : #PhLObject,
	#instVars : [
		'isHighlighted'
	],
	#category : 'PharoLauncher-Core-Model'
}

{ #category : #accessing }
PhLAbstractTemplateGroup >> children [
	^ self templatesAndGroups
]

{ #category : #testing }
PhLAbstractTemplateGroup >> isFast [
	"Answer true only if refreshing the content of the group is instantenous."
	^ false
]

{ #category : #testing }
PhLAbstractTemplateGroup >> isHighlighted [
	^ isHighlighted ifNil: [ isHighlighted := false ]
]

{ #category : #accessing }
PhLAbstractTemplateGroup >> isHighlighted: aBoolean [
	isHighlighted := aBoolean
]

{ #category : #testing }
PhLAbstractTemplateGroup >> isTemplateGroup [
	^ true
]

{ #category : #accessing }
PhLAbstractTemplateGroup >> name [
	^ self subclassResponsibility
]

{ #category : #printing }
PhLAbstractTemplateGroup >> printOn: aStream [
	aStream nextPutAll: self name; nextPutAll: ' Template group'
]

{ #category : #actions }
PhLAbstractTemplateGroup >> refresh [
	"Clear any cached data - this is a noop for non caching groups"
]

{ #category : #accessing }
PhLAbstractTemplateGroup >> templatesAndGroups [
	"Return a collection of all the templates and subgroups I contain"
	^ self subclassResponsibility
]
