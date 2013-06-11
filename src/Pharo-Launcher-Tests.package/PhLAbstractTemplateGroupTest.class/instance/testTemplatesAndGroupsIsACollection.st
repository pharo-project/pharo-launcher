tests
testTemplatesAndGroupsIsACollection
	| group templateAndGroups |
	group := self newGroup.
	templateAndGroups := group templatesAndGroups.
	self assert: templateAndGroups isCollection.
	self assert: templateAndGroups size > 0.
	group templatesAndGroups do: [ :templateOrGroup | self shouldnt: [ templateOrGroup isGroup ] raise: Error ]