*pharo-launcher-core
privOpenFileBrowserOn: pathString
	OSProcess command: ('cmd.exe /C "start {1}"' format: {pathString})