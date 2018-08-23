*PharoLauncher-Core
privOpenFileBrowserOn: pathString
	^ PhLProcessWrapper command: ('xdg-open "{1}"' format: {pathString})