tests
testTemplatesAndGroupsIsACollection
	| group templateAndGroups |
	group := self newGroup.
	templateAndGroups := group templatesAndGroups.
	self assert: templateAndGroups isCollection.
	self assert: templateAndGroups size > 0.
	group templatesAndGroups
		do: [ :templateOrGroup | templateOrGroup isGroup	"we just make sure the message can be sent without checking its result" ]