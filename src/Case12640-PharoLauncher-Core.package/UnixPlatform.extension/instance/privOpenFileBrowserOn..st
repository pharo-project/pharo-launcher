*pharoLauncher-Core-Commands
privOpenFileBrowserOn: pathString
	^ OSProcess command: ('xdg-open "{1}"' format: {pathString})