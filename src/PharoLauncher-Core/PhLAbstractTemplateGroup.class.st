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
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #accessing }
PhLAbstractTemplateGroup >> children [

	^ self templatesAndGroups
]

{ #category : #accessing }
PhLAbstractTemplateGroup >> icon [ 
	"icon used to display the group"
	self subclassResponsibility 
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

{ #category : #querying }
PhLAbstractTemplateGroup >> latestDevelopmentTemplate [ 
	^ self templatesAndGroups
		detect: [ :template | (template name includesSubstring: 'development version, latest') and: [ template name includesSubstring: PhLImageFinder defaultArchitectureString ] ]
		ifNone: [ NotFound signal: ('Could not find latest development image template in "{1}" template category.' format: {self name})]
]

{ #category : #querying }
PhLAbstractTemplateGroup >> latestStableTemplate [ 
	^ self templatesAndGroups
		detect: [ :template | (template name includesSubstring: 'stable') and: [ template name includesSubstring: PhLImageFinder defaultArchitectureString ] ]
		ifNone: [ NotFound signal: ('Could not find latest stable image template in "{1}" template category.' format: {self name})]
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

{ #category : #testing }
PhLAbstractTemplateGroup >> shouldComputeChildrenLazily [
	^ false
]

{ #category : #querying }
PhLAbstractTemplateGroup >> templateNamed: aTemplateName [
	^ self templatesAndGroups
		detect: [ :aTemplate | aTemplate name = aTemplateName ]
		ifNone: [ NotFound
				signal:
					aTemplateName asString
						, ' not found, please enter a correct template name' ]
]

{ #category : #querying }
PhLAbstractTemplateGroup >> templateShortNamed: aTemplateShortName [
	^ self templatesAndGroups
		detect: [ :aTemplate | aTemplate shortName = aTemplateShortName ]
		ifNone: [ NotFound
				signal:
					aTemplateShortName asString
						, ' not found, please enter a correct short template name' ]
]

{ #category : #accessing }
PhLAbstractTemplateGroup >> templatesAndGroups [
	"Return a collection of all the templates and subgroups I contain"
	^ self subclassResponsibility
]
