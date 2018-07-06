*pharoLauncher-Core-Commands
privOpenFileBrowserOn: pathString
	^ PhLProcessWrapper command: ('xdg-open "{1}"' format: {pathString})