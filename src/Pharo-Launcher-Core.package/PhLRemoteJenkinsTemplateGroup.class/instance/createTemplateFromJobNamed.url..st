as yet unclassified
createTemplateFromJobNamed: jobName url: jobUrl
	| xml artifact buildUrl zipFile |
	xml := self parseRemoteXml: jobUrl asZnUrl / 'lastSuccessfulBuild' / 'api' / 'xml'.
	artifact := (xml allElementsNamed: #artifact) first.
	zipFile := (artifact elementAt: #fileName) strings first.
	buildUrl := (xml allElementsNamed: #url) first strings first.
	^ PhLRemoteTemplate name: jobName url: buildUrl asZnUrl / zipFile categories: self categories