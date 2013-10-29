*pharo-launcher-core
privOpenFileBrowserOn: pathString
	^ OSProcess command: ('xdg-open "{1}"' format: {pathString})