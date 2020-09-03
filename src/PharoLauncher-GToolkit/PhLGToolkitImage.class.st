"
See PhLImage comment for setup details. GToolkit VM/image bundles can be downloaded at https://gtoolkit.com/download/.
"
Class {
	#name : #PhLGToolkitImage,
	#superclass : #PhLImage,
	#category : #'PharoLauncher-GToolkit'
}

{ #category : #testing }
PhLGToolkitImage class >> versionPrefix [
	^ PhLGToolkitVirtualMachine versionPrefix
]

{ #category : #accessing }
PhLGToolkitImage >> defaultArguments [
	^ super defaultArguments
		add: '--no-quit';
		add: '--interactive';
		yourself
]
