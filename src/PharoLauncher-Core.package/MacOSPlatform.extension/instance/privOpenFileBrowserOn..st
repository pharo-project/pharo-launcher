*pharoLauncher-Core-Commands
privOpenFileBrowserOn: pathString
	^ PhLProcessWrapper command: ('open "{1}"' format: {pathString})