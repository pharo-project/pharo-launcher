"
Class used for test purpose.
I override the default OS to return Mac Os Catalina 10.15.
It is used to test support of 32-bit app as  Mac Os Catalina is the first Mac Os version to drop support of 32-bit apps.
"
Class {
	#name : #PhLOsXCatalinaTestImage,
	#superclass : #PhLImage,
	#category : #'PharoLauncher-Tests-Functional'
}

{ #category : #testing }
PhLOsXCatalinaTestImage class >> isSubclassForLocation: aFileReference [ 
	^ false
]

{ #category : #'private - accessing' }
PhLOsXCatalinaTestImage >> os [
	^ TestMacOSXCatalinaPlatform new
]
