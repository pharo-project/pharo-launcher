"
I identify a version of a file published on a server, as given by the HTTP headers the server answers for this file.

Two stamps are equal when they identify the same version of the file.
"
Class {
	#name : 'PhLRemoteFileStamp',
	#superclass : 'Object',
	#instVars : [
		'etag',
		'lastModified'
	],
	#category : 'PharoLauncher-Core-Download',
	#package : 'PharoLauncher-Core',
	#tag : 'Download'
}

{ #category : 'instance creation' }
PhLRemoteFileStamp class >> etag: aString [

	^ self etag: aString lastModified: nil
]

{ #category : 'instance creation' }
PhLRemoteFileStamp class >> etag: aString lastModified: aDateAndTime [

	^ self new
		  setEtag: aString lastModified: aDateAndTime;
		  yourself
]

{ #category : 'instance creation' }
PhLRemoteFileStamp class >> fromDictionary: aDictionary [
	"Read a stamp written with #asDictionary, e.g. in a JSON file"

	^ self
		  etag: (aDictionary at: 'etag' ifAbsent: [ nil ])
		  lastModified: ((aDictionary at: 'lastModified' ifAbsent: [ nil ]) ifNotNil: [ :date | DateAndTime fromString: date ])
]

{ #category : 'instance creation' }
PhLRemoteFileStamp class >> fromHeaders: httpHeaders [

	| lastModified |
	lastModified := httpHeaders at: 'Last-Modified' ifAbsent: [ nil ].
	^ self
		  etag: (httpHeaders at: 'ETag' ifAbsent: [ nil ])
		  lastModified: (lastModified ifNotNil: [ ZnUtils parseHttpDate: lastModified ])
]

{ #category : 'comparing' }
PhLRemoteFileStamp >> = anObject [

	^ self class = anObject class and: [ etag = anObject etag ]
]

{ #category : 'converting' }
PhLRemoteFileStamp >> asDictionary [
	"A dictionary of strings, to write me in a JSON file"

	| dictionary |
	dictionary := Dictionary new.
	etag ifNotNil: [ dictionary at: 'etag' put: etag ].
	lastModified ifNotNil: [ dictionary at: 'lastModified' put: lastModified printString ].
	^ dictionary
]

{ #category : 'converting' }
PhLRemoteFileStamp >> asVmMetadata [
	"meta-inf.ston of a VM only held the stamp of its installed archive in the first versions"

	^ PhLVmMetadata new
		  setInstalledStamp: self;
		  yourself
]

{ #category : 'accessing' }
PhLRemoteFileStamp >> etag [

	^ etag
]

{ #category : 'comparing' }
PhLRemoteFileStamp >> hash [

	^ etag hash
]

{ #category : 'testing' }
PhLRemoteFileStamp >> isSameFileAs: aStamp [
	"The ETag identifies a version of a file. A server not sending it is compared on the modification date of the file.
	When the stamps cannot tell, the file is considered the same: no update is reported."

	(etag notNil and: [ aStamp etag notNil ]) ifTrue: [ ^ etag = aStamp etag ].
	(lastModified notNil and: [ aStamp lastModified notNil ]) ifTrue: [ ^ lastModified = aStamp lastModified ].
	^ true
]

{ #category : 'testing' }
PhLRemoteFileStamp >> identifiesSameFileAs: aStamp [
	"Answer whether both stamps tell it is the same file: same ETag, or else same modification date.
	Unlike #isSameFileAs:, stamps that cannot tell do not identify the same file."

	(etag notNil and: [ aStamp etag notNil ]) ifTrue: [ ^ etag = aStamp etag ].
	(lastModified notNil and: [ aStamp lastModified notNil ]) ifTrue: [ ^ lastModified = aStamp lastModified ].
	^ false
]

{ #category : 'testing' }
PhLRemoteFileStamp >> isNewerThan: aDateAndTime [

	^ lastModified isNotNil and: [ lastModified > aDateAndTime ]
]

{ #category : 'accessing' }
PhLRemoteFileStamp >> lastModified [

	^ lastModified
]

{ #category : 'accessing' }
PhLRemoteFileStamp >> publicationDate [
	"Answer the date the file was published on the server, nil if unknown."

	^ lastModified ifNotNil: [ lastModified asLocal asDate ]
]

{ #category : 'initialization' }
PhLRemoteFileStamp >> setEtag: aString lastModified: aDateAndTime [

	etag := aString.
	lastModified := aDateAndTime
]

