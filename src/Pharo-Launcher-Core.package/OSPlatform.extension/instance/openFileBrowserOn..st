*pharo-launcher-core
openFileBrowserOn: aFileReference
	"Opens an OS-specific file and directory browser on ==aFileReference==. If aFileReference is a file, opens the browser on its containing directory instead."
	| ref |
	(aFileReference isNil or: [ aFileReference exists not ])
		ifTrue: [ ^ nil ].
	ref := aFileReference isFile ifTrue: [ aFileReference parent ] ifFalse: [ aFileReference ].
	(ref isNil or: [ ref exists not ])
		ifTrue: [ ^ nil ].
	self privOpenFileBrowserOn: ref pathString