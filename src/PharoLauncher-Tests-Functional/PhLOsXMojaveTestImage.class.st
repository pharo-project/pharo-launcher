"
Class used for test purpose.
I override the default OS to return OS X Mojave 10.15 (used to test support of 32-bit app)
"
Class {
	#name : #PhLOsXMojaveTestImage,
	#superclass : #PhLImage,
	#category : #'PharoLauncher-Tests-Functional'
}

{ #category : #testing }
PhLOsXMojaveTestImage class >> isClassForLocation: aFileReference [ 
	^ false
]

{ #category : #'private - accessing' }
PhLOsXMojaveTestImage >> os [
	^ TestMacOSXMojavePlatform new
]
