"
I am what the Launcher knows about an installed virtual machine, stored in the `meta-inf.ston` file of its folder:
- the stamp of the archive it was installed from, and when it was installed,
- the stamp of the archive published on the server at the last check, and when this check was done.

The status of the virtual machine is read from me, without asking the server.
"
Class {
	#name : 'PhLVmMetadata',
	#superclass : 'Object',
	#instVars : [
		'installedStamp',
		'installedOn',
		'publishedStamp',
		'checkedOn'
	],
	#category : 'PharoLauncher-Core-Download',
	#package : 'PharoLauncher-Core',
	#tag : 'Download'
}

{ #category : 'accessing' }
PhLVmMetadata class >> fileName [

	^ 'meta-inf.ston'
]

{ #category : 'instance creation' }
PhLVmMetadata class >> inFolder: aFolder [
	"Answer the metadata stored in the given folder, empty metadata if there is none."

	| file |
	file := aFolder / self fileName.
	file exists ifFalse: [ ^ self new ].
	^ (file readStreamDo: [ :stream | STON fromStream: stream ]) asVmMetadata
]

{ #category : 'instance creation' }
PhLVmMetadata class >> installedFrom: aStamp [

	^ self new
		  recordInstallationOf: aStamp;
		  yourself
]

{ #category : 'converting' }
PhLVmMetadata >> asVmMetadata [

	^ self
]

{ #category : 'accessing' }
PhLVmMetadata >> checkedOn [

	^ checkedOn
]

{ #category : 'accessing' }
PhLVmMetadata >> installedOn [

	^ installedOn
]

{ #category : 'accessing' }
PhLVmMetadata >> installedStamp [

	^ installedStamp
]

{ #category : 'accessing' }
PhLVmMetadata >> publishedStamp [

	^ publishedStamp
]

{ #category : 'recording' }
PhLVmMetadata >> recordCheck: aPublishedStamp [

	publishedStamp := aPublishedStamp.
	checkedOn := DateAndTime now
]

{ #category : 'recording' }
PhLVmMetadata >> recordInstallationOf: aStamp [
	"Installing a virtual machine downloads the archive published on the server: it is also a check."

	installedStamp := aStamp.
	installedOn := DateAndTime now.
	self recordCheck: aStamp
]

{ #category : 'initialization' }
PhLVmMetadata >> setInstalledStamp: aStamp [

	installedStamp := aStamp
]

{ #category : 'storing' }
PhLVmMetadata >> storeInFolder: aFolder [

	(aFolder / self class fileName)
		ensureDelete;
		writeStreamDo: [ :stream | STON put: self onStreamPretty: stream ]
]
