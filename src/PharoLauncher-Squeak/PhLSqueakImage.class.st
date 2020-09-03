"
See PhLImage comment for setup details. Squeak VM/image bundles can be downloaded at https://squeak.org/downloads/
"
Class {
	#name : #PhLSqueakImage,
	#superclass : #PhLImage,
	#category : #'PharoLauncher-Squeak'
}

{ #category : #testing }
PhLSqueakImage class >> versionPrefix [
	^ PhLSqueakVirtualMachine versionPrefix
]
