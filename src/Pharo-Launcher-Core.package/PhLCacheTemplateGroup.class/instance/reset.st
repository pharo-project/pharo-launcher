action
reset
	"Request for showing up to date information *without* refreshing groups that would take time to refresh."
	"For network cache we replace the content by an indication that a full refresh is necessary"
	templatesAndGroups := Array with: PhLEmptyError new.