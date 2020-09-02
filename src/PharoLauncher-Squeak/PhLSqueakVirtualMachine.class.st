"
See PhLVirtualMachine's comment for general details. Squeak VM/image bundles can be downloaded at https://squeak.org/downloads/
"
Class {
	#name : #PhLSqueakVirtualMachine,
	#superclass : #PhLVirtualMachine,
	#category : #'PharoLauncher-Squeak'
}

{ #category : #querying }
PhLSqueakVirtualMachine class >> executableName [
	^ 'Squeak'
]

{ #category : #testing }
PhLSqueakVirtualMachine class >> versionPrefix [
	^ 'sq-'
]
