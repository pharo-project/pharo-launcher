"
I am what the Launcher knows about an installed virtual machine, stored in the `meta-inf.ston` file of its folder:
- the stamp of the archive it was installed from, and when it was installed,
- the stamp of the archive published on the server at the last check, and when this check was done,
- its version, and the modification time of the executable it was read from.

The status and the version of the virtual machine are read from me, without asking the server nor running the virtual machine.

Checks are done by a background process while the user may update virtual machines: reading and writing me, and replacing the folder of a virtual machine, are done in `PhLVmMetadata class>>#critical:`.
"
Class {
	#name : 'PhLVmMetadata',
	#superclass : 'Object',
	#instVars : [
		'installedStamp',
		'installedOn',
		'publishedStamp',
		'checkedOn',
		'version',
		'versionExecutableTime'
	],
	#classVars : [
		'Lock'
	],
	#category : 'PharoLauncher-Core-Download',
	#package : 'PharoLauncher-Core',
	#tag : 'Download'
}

{ #category : 'synchronization' }
PhLVmMetadata class >> critical: aBlock [
	"Evaluate the block while no other process reads or writes the metadata of a virtual machine, or replaces its folder"

	^ (Lock ifNil: [ Lock := Mutex new ]) critical: aBlock
]

{ #category : 'accessing' }
PhLVmMetadata class >> fileName [

	^ 'meta-inf.ston'
]

{ #category : 'instance creation' }
PhLVmMetadata class >> inFolder: aFolder [
	"Answer the metadata stored in the given folder, empty metadata if there is none or if it cannot be read (e.g. damaged file).
	The next check or installation stores it again."

	| file |
	file := aFolder / self fileName.
	^ self critical: [
		  file exists
			  ifTrue: [
				  [ (file readStreamDo: [ :stream | STON fromStream: stream ]) asVmMetadata ]
					  on: STONReaderError
					  do: [ self new ] ]
			  ifFalse: [ self new ] ]
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

{ #category : 'recording' }
PhLVmMetadata >> recordVersion: aString executableTime: aDateAndTime [

	version := aString.
	versionExecutableTime := aDateAndTime
]

{ #category : 'initialization' }
PhLVmMetadata >> setInstalledStamp: aStamp [

	installedStamp := aStamp
]

{ #category : 'storing' }
PhLVmMetadata >> storeInFolder: aFolder [

	self class critical: [
		(aFolder / self class fileName)
			ensureDelete;
			writeStreamDo: [ :stream | STON put: self onStreamPretty: stream ] ]
]

{ #category : 'accessing' }
PhLVmMetadata >> version [

	^ version
]

{ #category : 'accessing' }
PhLVmMetadata >> versionOfExecutableModifiedOn: aDateAndTime [
	"Answer the stored version if it was read from the executable as it is now, nil otherwise."

	^ versionExecutableTime = aDateAndTime
		  ifTrue: [ version ]
		  ifFalse: [ nil ]
]
