*pharo-launcher-core
privOpenFileBrowserOn: pathString
	^ OSProcess command: ('open "{1}"' format: {pathString})