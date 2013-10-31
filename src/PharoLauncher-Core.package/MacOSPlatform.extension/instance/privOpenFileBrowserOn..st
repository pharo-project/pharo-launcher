*pharoLauncher-Core-Commands
privOpenFileBrowserOn: pathString
	^ OSProcess command: ('open "{1}"' format: {pathString})