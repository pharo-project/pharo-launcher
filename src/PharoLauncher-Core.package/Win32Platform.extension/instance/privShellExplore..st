*pharoLauncher-Core-Commands
privShellExplore: folder
	"
	self privShellExplore: 'c:\'
	"

	^self privShellExecute: 'explore' file: folder parameters: '' directory: '' show: 5 "SW_SHOW"