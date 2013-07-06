accessing
testSelectors
	| selectors |
	selectors := super testSelectors.
	^ self name = 'PhLAbstractTemplateGroupTest'
		ifTrue: [ selectors copyWithout: #testTemplatesAndGroupsIsACollection	"to ignore because should only be run in subclasses" ]
		ifFalse: [ #() ]