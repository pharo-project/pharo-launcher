"
Copy the selected image pathname to the system clipboard.

"
Class {
	#name : #PhLCopyPathname,
	#superclass : #PhLImageCommand,
	#category : 'PharoLauncher-Core-Commands'
}

{ #category : #action }
PhLCopyPathname class >> group [
	^ 3
]

{ #category : #accessing }
PhLCopyPathname class >> icon [
	^ self iconNamed: #smallInfoIcon
]

{ #category : #accessing }
PhLCopyPathname class >> title [
	^ 'Copy pathname'
]

{ #category : #action }
PhLCopyPathname >> execute [
	Clipboard clipboardText: 
		$" asString, 
		self model singleImage file fullName , 
		$" asString.

]
