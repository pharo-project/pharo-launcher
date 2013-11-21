initialize-release
initializeTemplatesAndGroups
	"Set the default value of the simplifiedTemplatesAndGroups instance variable. Answer something meaninful only if this does not require time to compute."
	delegate isFast
		ifTrue: [ self refresh ]
		ifFalse: [ 
			"We replace the content by an indication that a full refresh is necessary"
			simplifiedTemplatesAndGroups := Array with: PhLEmptyError new ]