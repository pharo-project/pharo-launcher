initialize-release
initializeTemplatesAndGroups
	"Set the default value of the templatesAndGroups instance variable. Answer something meaninful only if this does not require time to compute."
	delegate isLocal
		ifTrue: [ self refresh ]
		ifFalse: [ 
			"We replace the content by an indication that a full refresh is necessary"
			templatesAndGroups := Array with: PhLEmptyError new ]