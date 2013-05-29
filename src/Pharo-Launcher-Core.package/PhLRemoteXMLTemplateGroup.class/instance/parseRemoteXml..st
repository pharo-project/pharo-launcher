remote action
parseRemoteXml: myurl
	^ XMLDOMParser parseDocumentFrom: myurl retrieveContents