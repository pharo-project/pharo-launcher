as yet unclassified
createTemplateFromXMLNode: jobNode
	| jobName jobUrl |
	jobName := (jobNode elementAt: #name) strings first.
	jobUrl := (jobNode elementAt: #url) strings first.
	self createTemplateFromJobNamed: jobName url: jobUrl